// 67d7842dbbe25473c3c32b93c0da8047785f30d78e8a024de1b57352245f9689
#ifndef X_HLS_NP_CHANNEL_H
#define X_HLS_NP_CHANNEL_H

#include "hls_stream.h"
#ifndef __SYNTHESIS__
#include <string.h>
#endif
namespace hls {
enum ALG {
  LOAD_BALANCING = 1,
  ROUND_ROBIN = 2,
  TAG_SELECT = 3
};

#ifdef __SYNTHESIS__
extern "C" void _ssdm_op_SpecNPortChannel(...);

template <typename T, unsigned N_READ_PORTS, unsigned DEPTH = 0, ALG A = LOAD_BALANCING> 
class SIMO;

template <typename T, unsigned N_READ_PORTS, unsigned DEPTH>
class SIMO<T, N_READ_PORTS, DEPTH, LOAD_BALANCING> {
public:
  stream<T> in;
  stream<T> out[N_READ_PORTS];
  SIMO(const char *name = nullptr) {
    #pragma HLS inline
    _ssdm_op_SpecNPortChannel(DEPTH, LOAD_BALANCING, 1, &in, N_READ_PORTS, out);
  }
};

template <typename T, unsigned N_WRITE_PORTS, unsigned DEPTH = 0, ALG A = LOAD_BALANCING> 
class MISO;

template <typename T, unsigned N_WRITE_PORTS, unsigned DEPTH>
class MISO<T, N_WRITE_PORTS, DEPTH, LOAD_BALANCING> {
public:
  stream<T> in[N_WRITE_PORTS];
  stream<T> out;
  MISO(const char *name = nullptr) {
    #pragma HLS inline
    _ssdm_op_SpecNPortChannel(DEPTH, LOAD_BALANCING, N_WRITE_PORTS, in, 1, &out);
  }
};

#else

#ifndef USE_THREAD_NP_CHANNEL
#ifdef HLS_STREAM_THREAD_SAFE
#define USE_THREAD_NP_CHANNEL
#else
#ifdef HLS_STREAM_THREAD_SAFE_EXPERIMENTAL
#define USE_THREAD_NP_CHANNEL
#endif
#endif
#endif

template <typename T, unsigned N_READ_PORTS, unsigned N_WRITE_PORTS>
class load_balancing_np : public stream_delegate<sizeof(T)> {
private:
  std::string name;
  std::deque<std::array<char, sizeof(T)> > _data;
#ifdef USE_THREAD_NP_CHANNEL
  std::mutex _mutex;
  std::condition_variable _condition_var;
#endif
protected:
  load_balancing_np() {}
  load_balancing_np(const char *n) : name(n) {}

public:
  virtual size_t size() {
#ifdef USE_THREAD_NP_CHANNEL
    std::lock_guard<std::mutex> lg(_mutex);
#endif
    return _data.size();
  }

  virtual bool read(void *elem) {
#ifdef USE_THREAD_NP_CHANNEL
    std::unique_lock<std::mutex> ul(_mutex);
    while (_data.empty()) {
      _condition_var.wait(ul);
    }
#else
    if (_data.empty()) {
      std::cout << "WARNING: n-ports channel '"
                << name
                << "' is read while empty,"
                << " which may result in RTL simulation hanging."
                << std::endl;
      return false;
    }
#endif
    
    memcpy(elem, _data.front().data(), sizeof(T));
    _data.pop_front();
    return true;
  }

  virtual bool read_nb(void *elem) {
#ifdef USE_THREAD_NP_CHANNEL
    std::lock_guard<std::mutex> lg(_mutex);
#endif
    bool is_empty = _data.empty();
    if (!is_empty) {
      memcpy(elem, _data.front().data(), sizeof(T));
      _data.pop_front();
    }
    return !is_empty;
  }

  virtual void write(const void *elem) {
#ifdef USE_THREAD_NP_CHANNEL
    std::unique_lock<std::mutex> ul(_mutex);
#endif
    std::array<char, sizeof(T)> elem_data;
    memcpy(elem_data.data(), elem, sizeof(T));
    _data.push_back(elem_data);
#ifdef USE_THREAD_NP_CHANNEL
    _condition_var.notify_one();
#endif
  }
};

template <typename T, unsigned N_READ_PORTS, unsigned DEPTH, ALG A = LOAD_BALANCING>
class SIMO;

template <typename T, unsigned N_READ_PORTS, unsigned DEPTH>
class SIMO<T, N_READ_PORTS, DEPTH, LOAD_BALANCING> : public load_balancing_np<T, N_READ_PORTS, 1> { 
public:
  stream<T> in;
  stream<T> out[N_READ_PORTS];
  SIMO() {
    in.set_delegate(this);
    for (int i = 0; i < N_READ_PORTS; i++)
      out[i].set_delegate(this);
  }

  SIMO(const char *name) : load_balancing_np<T, N_READ_PORTS, 1>(name) {
    in.set_delegate(this);
    for (int i = 0; i < N_READ_PORTS; i++)
      out[i].set_delegate(this);
  }
};

template <typename T, unsigned N_WRITE_PORTS, unsigned DEPTH, ALG A = LOAD_BALANCING>
class MISO;

template <typename T, unsigned N_WRITE_PORTS, unsigned DEPTH>
class MISO<T, N_WRITE_PORTS, DEPTH, LOAD_BALANCING> : public load_balancing_np<T, 1, N_WRITE_PORTS> { 
public:
  stream<T> in[N_WRITE_PORTS];
  stream<T> out;
  MISO() {
    out.set_delegate(this);
    for (int i = 0; i < N_WRITE_PORTS; i++)
      in[i].set_delegate(this);
  }

  MISO(const char *name) : load_balancing_np<T, 1, N_WRITE_PORTS>(name) {
    out.set_delegate(this);
    for (int i = 0; i < N_WRITE_PORTS; i++)
      in[i].set_delegate(this);
  }
};

#endif
}
#endif
