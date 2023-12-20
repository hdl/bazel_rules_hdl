// 67d7842dbbe25473c3c32b93c0da8047785f30d78e8a024de1b57352245f9689
#ifndef X_HLS_STREAMOFBLOCKS_H
#define X_HLS_STREAMOFBLOCKS_H

#ifndef __cplusplus
#error C++ is required to include this header file
#else

#ifdef __SYNTHESIS__
#include "etc/autopilot_ssdm_op.h"
#else
#include <queue>
#include <iostream>
#include <typeinfo>
#include <string>
#include <sstream>
#endif

#ifndef INLINE
#define INLINE inline __attribute__((always_inline))
#endif

#ifndef __has_attribute
#define __has_attribute(x) 0  // Compatibility with non-clang compilers.
#endif

#if __has_attribute(no_ctor)
#define NO_CTOR __attribute__((no_ctor))
#else
#define NO_CTOR
#endif

namespace hls {
template <typename __STREAM_T__>
class stream_buf {
#ifdef __SYNTHESIS__
  __STREAM_T__ data NO_CTOR;
#else
  std::string name;
  std::deque<__STREAM_T__*> data;
  int readLocks;
  int writeLocks;
  bool checkMultiple;
#endif
 
 public:
  INLINE stream_buf(
  int depth
#ifndef __SYNTHESIS__
  , 
  const char *n
#endif
  )
#ifndef __SYNTHESIS__
    : name(n ? n : "stream_of_blocks"), readLocks(0), writeLocks(0), checkMultiple(true)
#endif
  { 
#ifdef __SYNTHESIS__
    _ssdm_op_SpecChannel("data", 0, "", "", depth, depth * sizeof(__STREAM_T__), data, data);
    _ssdm_op_SpecPipoDepth(data, depth, "");
    _ssdm_op_SpecInterface(data, "mem_fifo", 0, 0, "", 0, 0, "", "", "", 2, 2, 16, 16, "", "");
#endif
  }

#ifndef __SYNTHESIS__
  INLINE void allow_multiple_locks() { checkMultiple = false; }
#endif

#ifndef __SYNTHESIS__
  void write_check() {
    if (writeLocks <= 0) {
        std::cerr << "ERROR: writing " << name << " before acquiring." << std::endl;
        abort();
    }
  }
  void read_check() {
    if (readLocks <= 0) {
        std::cerr << "ERROR: reading " << name << " before acquiring." << std::endl;
        abort();
    }
  }
#endif

  INLINE __STREAM_T__& read_acquire() {
#ifdef __SYNTHESIS__
    _ssdm_op_ReadReq(data, 2);
    return data;
#else
    if (checkMultiple && readLocks > 0) {
        std::cerr << "ERROR: acquiring " << name << " for reading more than once before releasing. Use braces to limit the lifetime of the lock object." << std::endl;
        abort();
    }
    readLocks++;
    
    if (data.empty()) {
        std::cerr << "ERROR: Reading from empty stream-of-blocks " << name << " (returning garbage data)" << std::endl;
        return *new __STREAM_T__[1];
    } else {
        return *data.front();
    }
#endif
  }
 
  INLINE void read_release() {
#ifdef __SYNTHESIS__
    _ssdm_op_Read(data, 2);
#else
    readLocks--;
    if (checkMultiple && readLocks != 0) {
        std::cerr << "INTERNAL ERROR: releasing " << name << " for reading too many times." << std::endl;
        abort();
    }
    data.pop_front();
#endif
  }
 
  INLINE __STREAM_T__& write_acquire() {
#ifdef __SYNTHESIS__
    _ssdm_op_WriteReq(data, 2);
    return data;
#else
    if (checkMultiple && writeLocks > 0) {
        std::cerr << "ERROR: acquiring " << name << " for writing more than once before releasing. Use braces to limit the lifetime of the lock object." << std::endl;
        abort();
    }
    writeLocks++;

    data.push_back(new __STREAM_T__[1]);
    return *data.back();
#endif
  }

  INLINE void write_release() {
#ifdef __SYNTHESIS__
    _ssdm_op_Write(data, 2);
#else
    writeLocks--;
    if (checkMultiple && writeLocks != 0) {
        std::cerr << "INTERNAL ERROR: releasing " << name << " for writing too many times." << std::endl;
        abort();
    }
#endif
  }
 
  INLINE bool empty() const {
#ifdef __SYNTHESIS__
    // connected to empty_n
    return !_ssdm_op_NbReadReq(data, 2);
#else
    return data.empty();
#endif
  }

  INLINE bool full() const {
#ifdef __SYNTHESIS__
    // connected to full_n
    return !_ssdm_op_NbWriteReq(data, 2);
#else
    return false;
#endif
  }

#ifdef EXPLICIT_ACQUIRE_RELEASE
  template <typename>
  friend class read_buf;
  template <typename>
  friend class write_buf;
#endif

  template <typename>
  friend class read_lock;
  template <typename>
  friend class write_lock;
};
 
template<typename __STREAM_T__, int DEPTH=2>
class stream_of_blocks;

#ifdef EXPLICIT_ACQUIRE_RELEASE
template <typename __STREAM_T__>
class read_buf {
  stream_of_blocks<__STREAM_T__>& res;
  __STREAM_T__* buf;
 
 public:
  INLINE read_buf(stream_of_blocks<__STREAM_T__>& s) : res(s) {
#ifdef __SYNTHESIS__
    buf = &(res.buf.data);
    _ssdm_op_SpecInterface(res.buf.data, "mem_fifo", 0, 0, "", 0, 0, "", "", "", 2, 2, 16, 16, "", "");
#else
    res.allow_multiple_locks();
#endif
  }

  INLINE void acquire() {
    buf = &res.read_acquire();
  }

  INLINE void release() {
    res.read_release();
  }

  INLINE ~read_buf() { }

  operator __STREAM_T__&() { 
#ifndef __SYNTHESIS__
    res.buf.read_check();
#endif
    return *buf;
  }

  INLINE __STREAM_T__& operator=(const __STREAM_T__& val) { 
#ifndef __SYNTHESIS__
    res.buf.read_check();
#endif
    buf = &val; 
    return *buf; 
  }
};
 
template <typename __STREAM_T__>
class write_buf {
  stream_of_blocks<__STREAM_T__>& res;
  __STREAM_T__* buf;
 
 public:
  write_buf(stream_of_blocks<__STREAM_T__>& s) : res(s) {
#ifdef __SYNTHESIS__
    buf = &(res.buf.data);
    _ssdm_op_SpecInterface(res.buf.data, "mem_fifo", 0, 0, "", 0, 0, "", "", "", 2, 2, 16, 16, "", "");
#else
    res.allow_multiple_locks();
#endif
  }

  INLINE void acquire() {
    buf = &res.write_acquire();
  }

  INLINE void release() {
    res.write_release();
  }

  INLINE ~write_buf() { }

  INLINE operator __STREAM_T__&() { 
#ifndef __SYNTHESIS__
    res.buf.write_check();
#endif
    return *buf; 
  }

  INLINE __STREAM_T__& operator=(const __STREAM_T__& val) {
#ifndef __SYNTHESIS__
    res.buf.write_check();
#endif
    buf = &val; 
    return *buf; 
  }
};
#endif

template <typename __STREAM_T__>
class read_lock {
  stream_of_blocks<__STREAM_T__>& res;
  __STREAM_T__& buf;
 
 public:
  INLINE read_lock(stream_of_blocks<__STREAM_T__>& s) : res(s), buf(res.read_acquire()) {
#ifdef __SYNTHESIS__
    _ssdm_op_SpecInterface(res.buf.data, "mem_fifo", 0, 0, "", 0, 0, "", "", "", 2, 2, 16, 16, "", "");
#endif
  }

  INLINE ~read_lock() { res.read_release(); }

  INLINE operator __STREAM_T__&() { return buf; }

  INLINE __STREAM_T__& operator=(const __STREAM_T__& val) { return buf = val; }
};
 
template <typename __STREAM_T__>
class write_lock {
  stream_of_blocks<__STREAM_T__>& res;
  __STREAM_T__& buf;
 
 public:
  INLINE write_lock(stream_of_blocks<__STREAM_T__>& s) : res(s), buf(res.write_acquire()) {
#ifdef __SYNTHESIS__
    _ssdm_op_SpecInterface(res.buf.data, "mem_fifo", 0, 0, "", 0, 0, "", "", "", 2, 2, 16, 16, "", "");
#endif
  }

  INLINE ~write_lock() { res.write_release(); }

  INLINE operator __STREAM_T__&() { return buf; }

  INLINE __STREAM_T__& operator=(const __STREAM_T__& val) { return buf = val; }
};
 
template <typename __STREAM_T__>
class stream_of_blocks<__STREAM_T__, 2> {
#ifdef EXPLICIT_ACQUIRE_RELEASE
  friend class read_buf<__STREAM_T__>; 
  friend class write_buf<__STREAM_T__>; 
#endif
  friend class read_lock<__STREAM_T__>; 
  friend class write_lock<__STREAM_T__>; 

  stream_buf<__STREAM_T__> buf;
 
 public:
  INLINE stream_of_blocks(int depth=2, char *name=0): buf(
#ifdef __SYNTHESIS__
    depth) { }
#else
    depth, name) { }
#endif

  INLINE bool full() { return buf.full(); }

  INLINE bool empty() { return buf.empty(); }

#ifndef __SYNTHESIS__
  INLINE void allow_multiple_locks() { buf.allow_multiple_locks(); }
#endif

 
 private:
  INLINE __STREAM_T__& read_acquire() { return buf.read_acquire(); }

  INLINE void read_release() { buf.read_release(); }
 
  INLINE __STREAM_T__& write_acquire() { return buf.write_acquire(); }

  INLINE void write_release() { buf.write_release(); }

  //__STREAM_T__& read(); TBD
  //void write(const __STREAM_T__&); TBD
};

template <typename __STREAM_T__, int DEPTH>
class stream_of_blocks: public stream_of_blocks<__STREAM_T__, 2> {
#ifdef EXPLICIT_ACQUIRE_RELEASE
  friend class read_buf<__STREAM_T__>; 
  friend class write_buf<__STREAM_T__>; 
#endif
  friend class read_lock<__STREAM_T__>; 
  friend class write_lock<__STREAM_T__>; 

 public:
  INLINE stream_of_blocks(): stream_of_blocks<__STREAM_T__, 2>(DEPTH) {}
};

}
#endif
#endif
