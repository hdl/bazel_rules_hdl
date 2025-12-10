/* -*- c++ -*-*/
/*
#-  (c) Copyright 2011-2019 Xilinx, Inc. All rights reserved.
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

 *
 */

#ifndef __SIM_AP_STREAM__
#define __SIM_AP_STREAM__

#ifndef __cplusplus
#error C++ is required to include this header file
#else

#ifdef __HLS_SYN__
#error ap_stream simulation header file is not applicable for synthesis
#else

#ifdef _MSC_VER
#define STRINGIZE_HELPER(x) #x
#define STRINGIZE(x) STRINGIZE_HELPER(x)
#define WARNING(desc) message(__FILE__ "(" STRINGIZE(__LINE__) ") : warning: " #desc)
#error WARNING(AP_STREAM macros are deprecated. Please use hls::stream<> from "hls_stream.h" instead.)
#else
#error AP_STREAM macros are deprecated. Please use hls::stream<> from "hls_stream.h" instead.
#endif

#include <queue>
#include <stdio.h>
#ifndef AP_STREAM_MAX_QUEUE_SIZE
//#define AP_STREAM_MAX_QUEUE_SIZE (1920*1080)
#define AP_STREAM_MAX_QUEUE_SIZE 0 // MAX_SIZE=0 leads to an elastic stream
#endif

#define C_EXTERN extern "C" // avoid C++ style name mangling

#define _paste(F,A) __AP_##F(A)

// Blocking Read & Write
#define AP_STREAM_READ(N,V) AP_STREAM_READ_FN(N)(V)
#define __AP_STREAM_READ_FN(N) ap_generic_stream_read_##N
#define AP_STREAM_READ_FN(name) _paste(STREAM_READ_FN,name)
#define AP_STREAM_WRITE(N,D) AP_STREAM_WRITE_FN(N)(D)
#define __AP_STREAM_WRITE_FN(N) ap_generic_stream_write_##N
#define AP_STREAM_WRITE_FN(name) _paste(STREAM_WRITE_FN,name)

// Nonblocking Read & Write
#define AP_STREAM_READ_NB(N,V) AP_STREAM_READ_NB_FN(N)(V)
#define __AP_STREAM_READ_NB_FN(N) ap_generic_stream_read_nb_##N
#define AP_STREAM_READ_NB_FN(name) _paste(STREAM_READ_NB_FN,name)
#define AP_STREAM_WRITE_NB(N,D) AP_STREAM_WRITE_NB_FN(N)(D)
#define __AP_STREAM_WRITE_NB_FN(N) ap_generic_stream_write_nb_##N
#define AP_STREAM_WRITE_NB_FN(name) _paste(STREAM_WRITE_NB_FN,name)

// Empty & Full
#define AP_STREAM_EMPTY(N) AP_STREAM_EMPTY_FN(N)()
#define __AP_STREAM_EMPTY_FN(N) ap_generic_stream_empty_##N
#define AP_STREAM_EMPTY_FN(name) _paste(STREAM_EMPTY_FN,name)
#define AP_STREAM_FULL(N) AP_STREAM_FULL_FN(N)()
#define __AP_STREAM_FULL_FN(N) ap_generic_stream_full_##N
#define AP_STREAM_FULL_FN(name) _paste(STREAM_FULL_FN,name)

/* Return signed char to be consistent with syn model, which returns
 * signed char for C compatibility.
 */

#define AP_STREAM_INTERFACE(type, name) \
    C_EXTERN void ap_generic_stream_read_##name(type& value); \
    C_EXTERN void ap_generic_stream_write_##name(type data); \
    C_EXTERN signed char ap_generic_stream_read_nb_##name(type& value); \
    C_EXTERN signed char ap_generic_stream_write_nb_##name(type data); \
    C_EXTERN signed char ap_generic_stream_empty_##name(); \
    C_EXTERN signed char ap_generic_stream_full_##name();

#define AP_STREAM_SIZE(type, name, size)         \
    ap_stream<type> ap_stream_##name(size, #name);    \
    AP_STREAM_INTERFACE_DEF(type, name)

#define AP_STREAM_INTERFACE_DEF(type, name) \
    C_EXTERN void ap_generic_stream_read_##name(type& value) {   \
        value = ap_stream_##name.pop(); \
    } \
    C_EXTERN void ap_generic_stream_write_##name(type data) {  \
        ap_stream_##name.push(data);   \
    } \
    C_EXTERN signed char ap_generic_stream_read_nb_##name(type& value) {   \
        signed char empty_n = ap_stream_##name.read(value);   \
        return empty_n;               \
    } \
    C_EXTERN signed char ap_generic_stream_write_nb_##name(type data) {   \
        signed char full_n = ap_stream_##name.write(data);   \
        return full_n;               \
    } \
    C_EXTERN signed char ap_generic_stream_empty_##name() {  \
        return ap_stream_##name.empty();   \
    } \
    C_EXTERN signed char ap_generic_stream_full_##name() {  \
        return ap_stream_##name.full();   \
    }

// Extern stream
#define EXTERN_AP_STREAM(type, name)         \
    extern ap_stream<type> ap_stream_##name;    \
    AP_STREAM_INTERFACE(type, name)
#define EXTERN_AP_STREAM_SIZE(type, name, size) EXTERN_AP_STREAM(type, name)

#ifdef AESL_TB
#define AP_STREAM(type, name) EXTERN_AP_STREAM(type, name)
#else
#define AP_STREAM(type, name) AP_STREAM_SIZE(type, name, 0)
#endif // AESL_TB

// FIFO stream
#define AP_STREAM_FIFO(type, name) AP_STREAM(type, name)
#define AP_STREAM_FIFO_SIZE(type, name, size) AP_STREAM_SIZE(type, name, size)
#define EXTERN_AP_STREAM_FIFO(type, name) EXTERN_AP_STREAM(type, name)
#define EXTERN_AP_STREAM_FIFO_SIZE(type, name, size) EXTERN_AP_STREAM_SIZE(type, name, size)
// HS stream
#define AP_STREAM_HS(type, name) AP_STREAM(type, name)
#define AP_STREAM_HS_SIZE(type, name, size) AP_STREAM_SIZE(type, name, size)
#define EXTERN_AP_STREAM_HS(type, name) EXTERN_AP_STREAM(type, name)
#define EXTERN_AP_STREAM_HS_SIZE(type, name, size) EXTERN_AP_STREAM_SIZE(type, name, size)

/////////////// ap_stream class //////////////
template <class T>
class ap_stream {

  protected:
    const char* _name;
    std::deque<T> _data; // container for the elements
    unsigned _capacity;
    
  public:
    // default constructor
    ap_stream(const char* name) {
        // capacity set to predefined maximum
        _capacity = AP_STREAM_MAX_QUEUE_SIZE;
        _name = name;
    }

    ap_stream(unsigned int max, const char* name) {
        _capacity = (max > 0) ? max : AP_STREAM_MAX_QUEUE_SIZE;
        _name = name;
    }

    /// Destructor
    /// Check status of the queue
    virtual ~ap_stream() {
        if (!empty())
            printf("WARNING: Stream \'%s\' remains non-empty when the program exits.\n", _name);
    }   

    typename std::deque<T>::size_type size() const {
        return _data.size();
    }

    typedef typename std::deque<T>::const_iterator iterator;

    iterator begin() const { return _data.begin(); }
    iterator end() const { return _data.end(); }

    bool empty() const { return _data.empty(); }
    bool full() const {
        if (_capacity > 0)    
            return (_data.size() >= _capacity); 
        return false;
    }

    bool read(T& head) {
        if (empty()) {
            head = T();
            return false;
        }
        head = pop();
        return true; 
    }

    T read() { return pop(); }

    bool write(const T& tail) {
        if (full())
            return false;
        push(tail);
        return true; 
    }

    void push(const T& elem) {
        if (!full())
            _data.push_back(elem);
        else {
            //printf("WARNING: Pushing a full FIFO \'%s\'; increasing FIFO capacity from %d to %d.\n", _name, _capacity, _capacity + 1);
            //assert(0);
            ++_capacity;
            _data.push_back(elem);
        }
    }

    T pop() {
        if (_data.empty()) {
            printf("WARNING: Popping an empty FIFO \'%s\'.\n", _name);
            return T();
            //assert(0);
        }
        T elem(_data.front());
        _data.pop_front();
        return elem;
    }

    T front() {
        if (_data.empty()) {
            printf("WARNING: Peeking the front of an empty FIFO \'%s\'.\n", _name);
            return T();
            //assert(0);
        }
        return _data.front();
    }

    T back() {
        if (_data.empty()) {
            printf("WARNING: Peeking the back of an empty FIFO \'%s\'.\n", _name);
            return T();
            //assert(0);
        }
        return _data.back();
    }

    /// Fifo size
    size_t size() {
        return _data.size();
    }
};

#endif //__SYNTHESIS__

#endif //__cplusplus

#endif //__SIM_AP_STREAM__


