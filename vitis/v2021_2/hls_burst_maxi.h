// 67d7842dbbe25473c3c32b93c0da8047785f30d78e8a024de1b57352245f9689
#ifndef X_HLS_BURST_MAXI_SIM_H
#define X_HLS_BURST_MAXI_SIM_H

/*
 * This file contains a C++ simulation model of hls::burst_maxi
 */
#ifndef __cplusplus

#error C++ is required to include this header file

#else

#include <list>
#include <map>
#include <iostream>
#include <assert.h>
#include "ap_int.h"

namespace hls {

struct MAXIAccessRecord {
  unsigned read_disp;
  unsigned write_disp;
  std::list<std::pair<size_t, unsigned>> ReadQ;
  std::list<std::pair<size_t, unsigned>> WriteQ;
  std::list<std::pair<size_t, unsigned>> WriteRespQ;
};

// A global map between pointer and MAXAccessRecord.
std::map<void *, MAXIAccessRecord> MAXIPointer2AccessRecordMap __attribute__((weak));

template<typename T>
class burst_maxi {
public:
  burst_maxi(T *p) : Ptr(p) {
    unsigned bitwidth = sizeof(T) * 8;
    assert(bitwidth != 0 && !(bitwidth & (bitwidth - 1)) &&
           "Error: bit width of hls::burst_maxi is not poower-of-2.");
    // Reset the MAXI access record to this pointer
    MAXIAccessRecord &R = MAXIPointer2AccessRecordMap[p];
    R.read_disp = 0;
    R.write_disp = 0;
    R.ReadQ.clear();
    R.WriteQ.clear();
    R.WriteRespQ.clear();
  }

  void read_request(size_t offset, unsigned len) {
    assert(len > 0);
    MAXIAccessRecord &R = MAXIPointer2AccessRecordMap[Ptr];
    R.ReadQ.push_back(std::make_pair(offset, len));
    std::list<std::pair<size_t, unsigned>> CurrentWriteQ = R.WriteQ;
    CurrentWriteQ.insert(CurrentWriteQ.end(), 
                         R.WriteRespQ.begin(), R.WriteRespQ.end());
    for (auto Pair : CurrentWriteQ) {
      if (overlap(offset, len, Pair.first, Pair.second)) {
        std::cerr << "Error: MAXI read request(offset = " << offset << ", len = " << len << ") overlaps with previous write request(offset = " << Pair.first << ", len = " << Pair.second << ")." << std::endl;
        abort();
      }
    }
  }

  T read() {
    MAXIAccessRecord &R = MAXIPointer2AccessRecordMap[Ptr];
    assert(!R.ReadQ.empty() && "Error: MAXI read without request."); 
    auto Pair = R.ReadQ.front();
    T V = Ptr[Pair.first + (R.read_disp++)];
    if (R.read_disp == Pair.second) {
      R.read_disp = 0;
      R.ReadQ.pop_front();
    }
    return V;     
  }

  void write_request(size_t offset, unsigned len) {
    assert(len > 0);
    MAXIAccessRecord &R = MAXIPointer2AccessRecordMap[Ptr];
    for (auto Pair : R.ReadQ) {
      if (overlap(offset, len, Pair.first, Pair.second)) {
        std::cerr << "Error: MAXI write request(offset = " << offset << ", len = " << len << ") overlaps with previous read request(offset = " << Pair.first << ", len = " << Pair.second << ")." << std::endl;
        abort();
      }
    }
    R.WriteQ.push_back(std::make_pair(offset, len));
  }

  void write(const T &val, ap_int<sizeof(T)> byte_enable_mask = -1) {
    MAXIAccessRecord &R = MAXIPointer2AccessRecordMap[Ptr];
    assert(!R.WriteQ.empty() && "Error: MAXI write without request."); 
    auto Pair = R.WriteQ.front();
    T *DstP = &Ptr[Pair.first + R.write_disp++];
    T Src = val;
    for (unsigned i = 0; i < sizeof(T); i++) {
      if (byte_enable_mask[i]) 
        reinterpret_cast<char *>(DstP)[i] = reinterpret_cast<char *>(&Src)[i];
    }

    if (R.write_disp == Pair.second) {
      R.write_disp = 0;
      R.WriteRespQ.push_back(Pair);
      R.WriteQ.pop_front();
    }   
  }
 
  void write_response() {
    MAXIAccessRecord &R = MAXIPointer2AccessRecordMap[Ptr];
    assert(!R.WriteRespQ.empty() && "Error: bad MAXI write response. Possible: 1) no corresponding write request; 2) some data still not written.");
    R.WriteRespQ.pop_front();
  }

private:
  T *Ptr;
  bool overlap(size_t a, unsigned a_len, size_t b, unsigned b_len) {
    return a <= b ? a + a_len > b : b + b_len > a;
  }
};


} // namespace hls

#endif // __cplusplus
#endif  // X_HLS_STREAM_SIM_H


