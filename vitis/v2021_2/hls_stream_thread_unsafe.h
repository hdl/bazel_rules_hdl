// 67d7842dbbe25473c3c32b93c0da8047785f30d78e8a024de1b57352245f9689
/*
#-  (c) Copyright 2011-2021 Xilinx, Inc. All rights reserved.
#-
#-  This file contains confidential and proprietary information
#-  of Xilinx, Inc. and is protected under U.S. and
#-  international copyright and other intellectual property
#-  laws.
#-
#-  DISCLAIMER
#-  This disclaimer is not a license and does not grant any
#-  rights to the materials distributed herewith. Except as
#-  otherwise provided in a valid license issued to you by
#-  Xilinx, and to the maximum extent permitted by applicable
#-  law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
#-  WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
#-  AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
#-  BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
#-  INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
#-  (2) Xilinx shall not be liable (whether in contract or tort,
#-  including negligence, or under any other theory of
#-  liability) for any loss or damage of any kind or nature
#-  related to, arising under or in connection with these
#-  materials, including for any direct, or any indirect,
#-  special, incidental, or consequential loss or damage
#-  (including loss of data, profits, goodwill, or any type of
#-  loss or damage suffered as a result of any action brought
#-  by a third party) even if such damage or loss was
#-  reasonably foreseeable or Xilinx had been advised of the
#-  possibility of the same.
#-
#-  CRITICAL APPLICATIONS
#-  Xilinx products are not designed or intended to be fail-
#-  safe, or for use in any application requiring fail-safe
#-  performance, such as life-support or safety devices or
#-  systems, Class III medical devices, nuclear facilities,
#-  applications related to the deployment of airbags, or any
#-  other applications that could lead to death, personal
#-  injury, or severe property or environmental damage
#-  (individually and collectively, "Critical
#-  Applications"). Customer assumes the sole risk and
#-  liability of any use of Xilinx products in Critical
#-  Applications, subject only to applicable laws and
#-  regulations governing limitations on product liability.
#-
#-  THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
#-  PART OF THIS FILE AT ALL TIMES. 
#- ************************************************************************


*/

#ifndef X_HLS_STREAM_THREAD_UNSAFE_SIM_H
#define X_HLS_STREAM_THREAD_UNSAFE_SIM_H

/*
 * This file contains a C++ model of hls::stream.
 * It defines C simulation model.
 */
#ifndef __cplusplus

#error C++ is required to include this header file

#else

//////////////////////////////////////////////
// C level simulation models for hls::stream
//////////////////////////////////////////////
#include <queue>
#include <iostream>
#include <typeinfo>
#include <string>
#include <sstream>
#include <unordered_map>
#include <cstring>
#include <array>

#ifdef HLS_STREAM_THREAD_SAFE_EXPERIMENTAL
#include <mutex>
#include <atomic>
#include <condition_variable>
#endif

#ifndef _MSC_VER
#include <cxxabi.h>
#include <stdlib.h>
#endif

namespace hls {

static int instance_count;
static int max_size;
static void stream_handler() {
//This functionality got broken after threadsafe/unsafe related changes. 
//Comment it for now as apparently no one is using it. No one has complained
//for many months. 
  //std::cout << "The maximum depth reached by any of the " << instance_count 
    //<< " hls::stream() instances in the design is " << max_size << std::endl;
}

template<size_t SIZE>
class stream_delegate {
public:
  virtual bool read(void *elem) = 0;
  virtual void write(const void *elem) = 0;
  virtual bool read_nb(void *elem) = 0;
  virtual size_t size() = 0;
};

template<size_t SIZE>
class stream_entity {
public:
  stream_entity() : d(0) {}

  bool read(void *elem) {
    if (d)
      return d->read(elem);

#ifdef HLS_STREAM_THREAD_SAFE_EXPERIMENTAL
    std::unique_lock<std::mutex> ul(mutex);
    while (data.empty()) {
      condition_var.wait(ul);
    }
#else
#ifdef HLS_STREAM_WAIT_FOR_DATA_IN_BLOCKING_READ
    while(data.empty())
      ;
#endif
    if (data.empty()) {
      std::cout << "WARNING: Hls::stream '"
                << name
                << "' is read while empty,"
                << " which may result in RTL simulation hanging."
                << std::endl;
      return false;
    }
#endif
    std::array<char, SIZE> &elem_data = data.front();
    memcpy(elem, elem_data.data(), SIZE);
    data.pop_front();
    return true;
  }

  void write(const void *elem) {
    if (d) {
      d->write(elem);
      return;
    }

    std::array<char, SIZE> elem_data;
    memcpy(elem_data.data(), elem, SIZE);

#ifdef HLS_STREAM_THREAD_SAFE_EXPERIMENTAL
    std::unique_lock<std::mutex> ul(mutex);
#endif
    data.push_back(elem_data);
#ifdef HLS_STREAM_THREAD_SAFE_EXPERIMENTAL
    condition_var.notify_one();
#else
    if (max_size < data.size()) 
      max_size = size();
#endif
  }

  /// Nonblocking read
  bool read_nb(void *elem) {
    if (d)
      return d->read_nb(elem);

#ifdef HLS_STREAM_THREAD_SAFE_EXPERIMENTAL
    std::lock_guard<std::mutex> lg(mutex);
#endif
    bool is_empty = data.empty();
    if (!is_empty) {
      std::array<char, SIZE> &elem_data = data.front();
      memcpy(elem, elem_data.data(), SIZE);
      data.pop_front();
    }
    return !is_empty; 
  }

  /// Fifo size
  size_t size() {
    if (d)
      return d->size();

#ifdef HLS_STREAM_THREAD_SAFE_EXPERIMENTAL
    std::lock_guard<std::mutex> lg(mutex);
#endif
    return data.size();
  }

  /// Set name for c-sim debugging.
  void set_name(const char *n) {
#ifdef HLS_STREAM_THREAD_SAFE_EXPERIMENTAL
    std::lock_guard<std::mutex> lg(mutex);
#endif
    name = n;
  }

  stream_delegate<SIZE> *d;
  std::string name;
  std::deque<std::array<char, SIZE> > data;
#ifdef HLS_STREAM_THREAD_SAFE_EXPERIMENTAL  
  std::mutex mutex;
  std::condition_variable condition_var;
#endif
};

template<size_t SIZE>
class stream_map {
public:
  static size_t count(void *p) {
#ifdef HLS_STREAM_THREAD_SAFE_EXPERIMENTAL
    std::lock_guard<std::mutex> lg(get_mutex());
#endif
    return get_map().count(p);
  }

  static void insert(void *p, const std::string &name) {
#ifdef HLS_STREAM_THREAD_SAFE_EXPERIMENTAL
    std::lock_guard<std::mutex> lg(get_mutex());
#endif
    auto &map = get_map();
    map.erase(p);
    map[p].name = name;
  }

  static stream_entity<SIZE> &get_entity(void *p) {
#ifdef HLS_STREAM_THREAD_SAFE_EXPERIMENTAL
    std::lock_guard<std::mutex> lg(get_mutex());
#endif
    return get_map()[p];
  }

  static unsigned get_counter() {
#ifdef HLS_STREAM_THREAD_SAFE_EXPERIMENTAL
    static std::atomic<unsigned> counter(0);
#else
    static unsigned counter = 0;
#endif
    return counter++;
  }

private:
#ifdef HLS_STREAM_THREAD_SAFE_EXPERIMENTAL
  static std::mutex &get_mutex() {
    static std::mutex *mutex = new std::mutex();
    return *mutex;
  }
#endif
  static std::unordered_map<void*, stream_entity<SIZE> > &get_map() {
    static std::unordered_map<void*, stream_entity<SIZE> > *map = 
        new std::unordered_map<void*, stream_entity<SIZE> >();
    return *map;
  }
};

template<typename __STREAM_T__, int DEPTH=0>
class stream;
template<typename __STREAM_T__>
class stream<__STREAM_T__, 0> 
{
  typedef stream_map<sizeof(__STREAM_T__)> map_t;
  protected:
    __STREAM_T__ _data;
    
  protected:
    void register_handler() {
      if(instance_count == 0) 
        const int handler = std::atexit(stream_handler);
      instance_count++;
    } 

  public:
    /// Constructors
    // Keep consistent with the synthesis model's constructors
    stream() {
#ifndef HLS_STREAM_THREAD_SAFE_EXPERIMENTAL
        register_handler();
#endif
        std::stringstream ss;
#ifndef _MSC_VER
        char* _demangle_name = abi::__cxa_demangle(typeid(*this).name(), 0, 0, 0);
        if (_demangle_name) {
          ss << _demangle_name;
          free(_demangle_name);
        }
        else {
          ss << "hls_stream";
        }
#else
        ss << typeid(*this).name();
#endif

        ss << map_t::get_counter();
        map_t::insert(&_data, ss.str());
    }

    stream(const char *name) {
    // default constructor,
    // capacity set to predefined maximum
      map_t::insert(&_data, name);
#ifndef HLS_STREAM_THREAD_SAFE_EXPERIMENTAL
      register_handler();
#endif
    }

  /// Make copy constructor and assignment operator private
  /// They should not be called.
  private:
    stream(const stream< __STREAM_T__ >& chn):
        _data(chn._data) {
    }

    stream& operator = (const stream< __STREAM_T__ >& chn) {
        return *this;
    }

  public:
    /// Overload >> and << operators to implement read() and write()
    void operator >> (__STREAM_T__& rdata) {
        read(rdata);
    }

    void operator << (const __STREAM_T__& wdata) {
        write(wdata);
    }


  public:
    /// Destructor
    /// Check status of the queue
    ~stream() {
      if (!empty())
      {
          std::cout << "WARNING: Hls::stream '" 
                    << map_t::get_entity(&_data).name
                    << "' contains leftover data,"
                    << " which may result in RTL simulation hanging."
                    << std::endl;
      }
    }

    bool exist() {
      return map_t::count(&_data);
    }

    /// Status of the queue
    bool empty() {
      return size() == 0;
    }    

    bool full() const { return false; }

    /// Blocking read
    void read(__STREAM_T__& head) {
        head = read();
    }

    /// Blocking read
    bool read_dep(__STREAM_T__& head, volatile bool flag) {
        head = read();
        return flag;
    }

    __STREAM_T__ read() {
      __STREAM_T__ elem;
      auto &entity = map_t::get_entity(&_data);
      if (!entity.read(&elem)) 
        elem = __STREAM_T__();
      return elem;
    }

    /// Blocking write
    void write(const __STREAM_T__& tail) { 
      map_t::get_entity(&_data).write(&tail);
    }

    /// Blocking write
    bool write_dep(const __STREAM_T__& tail, volatile bool flag) { 
      write(tail);
      return flag;
    }

    /// Nonblocking read
    bool read_nb(__STREAM_T__& head) {
      __STREAM_T__ elem;
      auto &entity = map_t::get_entity(&_data);
      bool not_empty = entity.read_nb(&elem);
      if (not_empty)
        head = elem;
      return not_empty;
    }

    /// Nonblocking write
    bool write_nb(const __STREAM_T__& tail) {
        bool is_full = full();
        write(tail);
        return !is_full;
    }

    /// Fifo size
    size_t size() {
      return map_t::get_entity(&_data).size();
    }

    /// Set name for c-sim debugging.
    void set_name(const char *name) { 
      map_t::get_entity(&_data).set_name(name);
    }

    void set_delegate(stream_delegate<sizeof(__STREAM_T__)> *d) {
      map_t::get_entity(&_data).d = d;
    }
};

template<typename __STREAM_T__, int DEPTH>
class stream : public stream<__STREAM_T__, 0> {
public:
  stream() {}
  stream(const char* name) : stream<__STREAM_T__, 0>(name) {}
};

} // namespace hls

#endif // __cplusplus
#endif  // X_HLS_STREAM_THREAD_UNSAFE_SIM_H


