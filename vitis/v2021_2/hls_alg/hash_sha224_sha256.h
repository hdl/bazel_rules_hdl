// 67d7842dbbe25473c3c32b93c0da8047785f30d78e8a024de1b57352245f9689
/*****************************************************************************
 *
 *     Author: Xilinx, Inc.
 *
 *     This text contains proprietary, confidential information of
 *     Xilinx, Inc. , is distributed by under license from Xilinx,
 *     Inc., and may be used, copied and/or disclosed only pursuant to
 *     the terms of a valid license agreement with Xilinx, Inc.
 *
 *     XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"
 *     AS A COURTESY TO YOU, SOLELY FOR USE IN DEVELOPING PROGRAMS AND
 *     SOLUTIONS FOR XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE,
 *     OR INFORMATION AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE,
 *     APPLICATION OR STANDARD, XILINX IS MAKING NO REPRESENTATION
 *     THAT THIS IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT,
 *     AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE
 *     FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY
 *     WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE
 *     IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR
 *     REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF
 *     INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 *     FOR A PARTICULAR PURPOSE.
 *
 *     Xilinx products are not intended for use in life support appliances,
 *     devices, or systems. Use in such applications is expressly prohibited.
 *
 *     (c) Copyright 2018 Xilinx Inc.
 *     All rights reserved.
 *
 *****************************************************************************/

/**
 * @file hash_sha224_sha256.h
 * @brief SHA224/SHA256 template function implementation.
 *
 * This file is part of HLS Algorithm Library.
 * SHA224 and SHA256 are specified by "RFC 6234: US Secure Hash Algorithms".
 */

#ifndef _X_HLS_ALG_HASH_H_
#error \
    "hls_alg/hash_sha224_sha256.h should not be inlcuded directly, use top-level hls_alg.h instead!"
#endif

#ifndef _X_HLS_ALG_HASH_SHA224_SHA256_H_
#define _X_HLS_ALG_HASH_SHA224_SHA256_H_

#ifndef __cplusplus
#error \
    "hls_alg::sha256 and hls_alg::sha224 uses hls::stream<> interface, and thus requires C++"
#endif

#if defined(__cplusplus) && (__cplusplus >= 201402L)
#define HLS_DEPRECATED_FUNC(removal, replacement) \
   [[deprecated("It will be removed from HLS in Release " #removal ", please consider using " #replacement " instead.")]]
#elif defined(__GNUC__) || defined(__clang__)
#define HLS_DEPRECATED_FUNC(removal, replacement) \
   __attribute__((deprecated("It will be removed from HLS in Release " #removal ", please consider using " #replacement " instead.")))
#elif defined(_MSC_VER)
#define HLS_DEPRECATED_FUNC(removal, replacement) \
   __declspec(deprecated("It will be removed from HLS in Release " #removal ", please consider using " #replacement " instead."))
#else
#error("Unsupported compiler")
#endif


#include "hls_stream.h"

// For debug
#if !defined(__SYNTHESIS__) && defined(_HLSCLIB_DEBUG_)
#include <cstdio>
#define _DEBUG_PRINT(msg...) \
  do {                         \
    printf(msg);   \
  } while (0)
#else
#define _DEBUG_PRINT(msg...) (static_cast<void>(0))
#endif

// for wide output
#include <ap_int.h>

#define ROTR(n, x) ((x >> n) | (x << (32 - n)))
#define ROTL(n, x) ((x << n) | (x >> (32 - n)))
#define SHR(n, x) (x >> n)
#define CH(x, y, z) ((x & y) ^ ((~x) & z))
#define MAJ(x, y, z) ((x & y) ^ (x & z) ^ (y & z))
#define BSIG0(x) (ROTR(2, x) ^ ROTR(13, x) ^ ROTR(22, x))
#define BSIG1(x) (ROTR(6, x) ^ ROTR(11, x) ^ ROTR(25, x))
#define SSIG0(x) (ROTR(7, x) ^ ROTR(18, x) ^ SHR(3, x))
#define SSIG1(x) (ROTR(17, x) ^ ROTR(19, x) ^ SHR(10, x))

// XXX HLS currently does not support cross-compilation, and assumes the target
// to have same endianness as build host. HLS is only available on X86 machines,
// and thus the code is always little-endian.
#if !defined(__BYTE_ORDER__) && defined(__ORDER_BIG_ENDIAN__) && \
    __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
#error "HLS only supports little endian systems!"
#endif

namespace hls_alg_internal {

/// Processing block
struct SHA256Block {
  uint32_t M[16];
};

/// @brief Generate 512bit processing blocks for SHA224/SHA256.
/// @tparam msg_T the input stream type.
/// @param msg_strm the message being hashed.
/// @param blk_strm the output block.
/// @param len the message size in byte.
template <typename msg_T>
void sha256_generate(hls::stream<msg_T>& msg_strm,
                     hls::stream<SHA256Block>& blk_strm, uint64_t len) {

  /// message length in bit.
  const uint64_t L = len * 8;

  // message stream width in bit.
  const unsigned int iw = sizeof(msg_T) * 8;
  HLS_ALG_STATIC_ASSERT((iw == 8), "Unsupportted stream width");

  /// number of bytes not in blocks yet.
  int64_t n;

LOOP_SHA256_PAD_PHASE1_MAIN:
  for (n = len; n > 64; n -= 64) {
#ifdef __SYNTHESIS__
#pragma HLS LOOP_TRIPCOUNT min = 1 max = 1
#endif
    /// message block.
    SHA256Block B;

    // this block will hold 64 byte of message.
    if (iw == 8) {
    LOOP_SHA256_PAD_PHASE1_IW8:
      for (int i = 0; i < 16; ++i) {
#ifdef __SYNTHESIS__
#pragma HLS unroll
#endif // __SYNTHESIS__
        uint32_t l;
        l = 0xff000000UL & (((uint8_t)msg_strm.read()) << 24);
        l |= 0x00ff0000UL & (((uint8_t)msg_strm.read()) << 16);
        l |= 0x0000ff00UL & (((uint8_t)msg_strm.read()) << 8);
        l |= 0x000000ffUL & (((uint8_t)msg_strm.read()));
        B.M[i] = l;
        _DEBUG_PRINT("DEBUG: M[%d] =\t%08x (32bx16)\n", i, B.M[i]);
      }
    } else {
      // TODO
    }
    // send block
    blk_strm.write(B);
    _DEBUG_PRINT("DEBUG: block sent\n");
  }

  // new block to handle remaining message, pad 1 and L.

  /// message block.
  SHA256Block B;

LOOP_SHA256_PAD_CLEAR_1:
  for (int i = 0; i < 16; ++i) {
#ifdef __SYNTHESIS__
#pragma HLS unroll
#endif // __SYNTHESIS__
    B.M[i] = 0UL;
  }

  // fill in message.
  if (iw == 8) {
    /// buffer for bytes to long.
    uint32_t wbuf;
  LOOP_SHA256_PAD_PHASE2_IW8:
    for (int64_t i = 0; i < n; ++i) {
#ifdef __SYNTHESIS__
#pragma HLS LOOP_TRIPCOUNT min = 1 max = 63
#endif
      short nb = i & 0x3;
      uint8_t b = msg_strm.read();
      if (nb == 0) {
        wbuf = ((uint32_t)b << 24);
      } else if (nb == 1) {
        wbuf |= ((uint32_t)b << 16);
      } else if (nb == 2) {
        wbuf |= ((uint32_t)b << 8);
      } else {
        wbuf |= ((uint32_t)b);
        B.M[i >> 2] = wbuf;
        _DEBUG_PRINT("DEBUG: M[%ld] =\t%08x (32b)\n", i >> 2, wbuf);
      }
    }
    // pad 1
    if ((n & 0x3) == 0) {
      if (n != 64) {
        B.M[n >> 2] = 0x80000000UL;
        _DEBUG_PRINT("DEBUG: M[%ld] =\t%08x (pad 1)\n", n >> 2, B.M[n >> 2]);
      }
    } else if ((n & 0x3) == 1) {
      B.M[n >> 2] = 0x00800000UL | wbuf;
      _DEBUG_PRINT("DEBUG: M[%ld] =\t%08x (pad 1)\n", n >> 2, B.M[n >> 2]);
    } else if ((n & 0x3) == 2) {
      B.M[n >> 2] = 0x00008000UL | wbuf;
      _DEBUG_PRINT("DEBUG: M[%ld] =\t%08x (pad 1)\n", n >> 2, B.M[n >> 2]);
    } else {
      B.M[n >> 2] = 0x00000080UL | wbuf;
      _DEBUG_PRINT("DEBUG: M[%ld] =\t%08x (pad 1)\n", n >> 2, B.M[n >> 2]);
    }
  } else {
    // TODO
  }

  // test space left for length.
  if (n >= 56) {
    // can not fit in the length, send it.
    blk_strm.write(B);
    _DEBUG_PRINT("DEBUG: block sent\n");
    // create new
    if (n == 64) {
      B.M[0] = 0x80000000UL;
      _DEBUG_PRINT("DEBUG: M[0] =\t%08x (pad 1)\n", B.M[0]);
    } else {
      B.M[0] = 0UL;
      _DEBUG_PRINT("DEBUG: M[0] =\t%08x (zero)\n", B.M[0]);
    }
  LOOP_SHA256_PAD_CLEAR_2:
    for (int i = 1; i < 14; ++i) {
#ifdef __SYNTHESIS__
#pragma HLS unroll
#endif // __SYNTHESIS__
      B.M[i] = 0UL;
    }
  }

  // append length
  // XXX due to big-endian assumption, write MSB at lower address.
  B.M[14] = (uint32_t)(0xffffffffUL & (L >> 32));
  B.M[15] = (uint32_t)(0xffffffffUL & (L));
  _DEBUG_PRINT("DEBUG: M[%d] =\t%08x (L)\n", 14, B.M[14]);
  _DEBUG_PRINT("DEBUG: M[%d] =\t%08x (L)\n", 15, B.M[15]);

  // send and done.
  blk_strm.write(B);
  _DEBUG_PRINT("DEBUG: block sent\n");

} // sha256_generate

/// @brief Static config for SHA224 and SHA256.
template <bool do_sha224>
struct sha256_digest_config;

template <>
struct sha256_digest_config<true> {
  static const short numH = 7;
};

template <>
struct sha256_digest_config<false> {
  static const short numH = 8;
};

/// @brief Digest message blocks and emit final hash.
/// @tparam do_sha224 the flag to calculate SHA224 instead of SHA256
/// @tparam hash_T the input hash stream content type.
/// @param blk_strm the message block.
/// @param len the message size in byte.
/// @param hash_strm the hash result stream.
template <bool do_sha224, typename hash_T>
inline void sha256_digest(hls::stream<SHA256Block>& blk_strm,
                          hls::stream<hash_T>& hash_strm, uint64_t len) {
  /// constant K
  static const uint32_t K[64] = {
      0x428a2f98UL, 0x71374491UL, 0xb5c0fbcfUL, 0xe9b5dba5UL, 0x3956c25bUL,
      0x59f111f1UL, 0x923f82a4UL, 0xab1c5ed5UL, 0xd807aa98UL, 0x12835b01UL,
      0x243185beUL, 0x550c7dc3UL, 0x72be5d74UL, 0x80deb1feUL, 0x9bdc06a7UL,
      0xc19bf174UL, 0xe49b69c1UL, 0xefbe4786UL, 0x0fc19dc6UL, 0x240ca1ccUL,
      0x2de92c6fUL, 0x4a7484aaUL, 0x5cb0a9dcUL, 0x76f988daUL, 0x983e5152UL,
      0xa831c66dUL, 0xb00327c8UL, 0xbf597fc7UL, 0xc6e00bf3UL, 0xd5a79147UL,
      0x06ca6351UL, 0x14292967UL, 0x27b70a85UL, 0x2e1b2138UL, 0x4d2c6dfcUL,
      0x53380d13UL, 0x650a7354UL, 0x766a0abbUL, 0x81c2c92eUL, 0x92722c85UL,
      0xa2bfe8a1UL, 0xa81a664bUL, 0xc24b8b70UL, 0xc76c51a3UL, 0xd192e819UL,
      0xd6990624UL, 0xf40e3585UL, 0x106aa070UL, 0x19a4c116UL, 0x1e376c08UL,
      0x2748774cUL, 0x34b0bcb5UL, 0x391c0cb3UL, 0x4ed8aa4aUL, 0x5b9cca4fUL,
      0x682e6ff3UL, 0x748f82eeUL, 0x78a5636fUL, 0x84c87814UL, 0x8cc70208UL,
      0x90befffaUL, 0xa4506cebUL, 0xbef9a3f7UL, 0xc67178f2UL};
#ifdef __SYNTHESIS__
#pragma HLS array_partition variable = K complete
#endif // __SYNTHESIS__

  /// total number blocks to digest.
  uint64_t blk_num = (len >> 6) + 1 + ((len & 0x3f) > 55);
  // _DEBUG_PRINT("expect %ld blocks.\n", blk_num);

  /// internal states
  uint32_t H[8];
#ifdef __SYNTHESIS__
#pragma HLS array_partition variable = H complete
#endif // __SYNTHESIS__

  // initialize
  if (do_sha224) {
    H[0] = 0xc1059ed8UL;
    H[1] = 0x367cd507UL;
    H[2] = 0x3070dd17UL;
    H[3] = 0xf70e5939UL;
    H[4] = 0xffc00b31UL;
    H[5] = 0x68581511UL;
    H[6] = 0x64f98fa7UL;
    H[7] = 0xbefa4fa4UL;
  } else {
    H[0] = 0x6a09e667UL;
    H[1] = 0xbb67ae85UL;
    H[2] = 0x3c6ef372UL;
    H[3] = 0xa54ff53aUL;
    H[4] = 0x510e527fUL;
    H[5] = 0x9b05688cUL;
    H[6] = 0x1f83d9abUL;
    H[7] = 0x5be0cd19UL;
  }

LOOP_SHA256_DIGEST_MAIN:
  for (uint64_t n = 0; n < blk_num; ++n) {
#ifdef __SYNTHESIS__
#pragma HLS LOOP_TRIPCOUNT min = 1 max = 1
#endif
    /// Input block.
    SHA256Block blk = blk_strm.read();

    _DEBUG_PRINT("DEBUG: block =\n");
    for (int i = 0; i < 16; ++i) {
      _DEBUG_PRINT("\tM[%d] =\t%08x\n", i, blk.M[i]);
    }
    _DEBUG_PRINT("\n");

    /// working variables.
    uint32_t a, b, c, d, e, f, g, h;

    // loading working variables.
    a = H[0];
    b = H[1];
    c = H[2];
    d = H[3];
    e = H[4];
    f = H[5];
    g = H[6];
    h = H[7];

    /// message schedule W, from message or
    uint32_t W[64];
#ifdef __SYNTHESIS__
#pragma HLS array_partition variable = W complete
#endif // __SYNTHESIS__

    uint32_t Kt = K[0];
    uint32_t Wt = blk.M[0];
    W[0] = blk.M[0];
  LOOP_SHA256_UPDATE_64_ROUNDS:
    for (short t = 0; t < 64; ++t) {
#ifdef __SYNTHESIS__
#pragma HLS pipeline II = 1
#endif // __SYNTHESIS__

      /// temporal variables
      uint32_t T1, T2;
      T1 = h + BSIG1(e) + CH(e, f, g) + Kt + Wt;
      T2 = BSIG0(a) + MAJ(a, b, c);

      // update working variables.
      h = g;
      g = f;
      f = e;
      e = d + T1;
      d = c;
      c = b;
      b = a;
      a = T1 + T2;

      _DEBUG_PRINT(
          "DEBUG: Kt=%08x, Wt=%08x\n"
          "\ta=%08x, b=%08x, c=%08x, d=%08x\n"
          "\te=%08x, f=%08x, g=%08x, h=%08x\n",
          Kt, Wt, a, b, c, d, e, f, g, h);

      // for next cycle
      Kt = K[(t + 1) & 63];
      if (t < 15) {
        Wt = blk.M[(t + 1) & 63];
        W[t + 1] = Wt;
      } else {
        Wt = SSIG1(W[t - 1]) + W[t - 6] + SSIG0(W[t - 14]) + W[t - 15];
        W[(t + 1) & 63] = Wt;
      }
    }

    // store working variables to internal states.
    H[0] = a + H[0];
    H[1] = b + H[1];
    H[2] = c + H[2];
    H[3] = d + H[3];
    H[4] = e + H[4];
    H[5] = f + H[5];
    H[6] = g + H[6];
    H[7] = h + H[7];
  }

  /// output hash stream width in bit.
  const unsigned int ow = sizeof(hash_T) * 8;
  HLS_ALG_STATIC_ASSERT(
      (ow == 8) || (ow == 32) || (ow == 256) || (ow == 224 && do_sha224),
      "Unsupportted stream width");

  // Emit digest
  if (ow == 8) {
  LOOP_SHA256_EMIT_OW8:
    for (short i = 0; i < sha256_digest_config<do_sha224>::numH; ++i) {
#ifdef __SYNTHESIS__
#pragma HLS unroll
#endif // __SYNTHESIS__
      uint32_t l = H[i];
      // XXX due to big-endian assumption, write MSB first.
      uint8_t t0 = (((l) >> 24) & 0xff);
      uint8_t t1 = (((l) >> 16) & 0xff);
      uint8_t t2 = (((l) >> 8) & 0xff);
      uint8_t t3 = (((l)) & 0xff);
      hash_strm.write(t0);
      hash_strm.write(t1);
      hash_strm.write(t2);
      hash_strm.write(t3);
    }
  } else if (ow == 32) {
  LOOP_SHA256_EMIT_OW32:
    for (short i = 0; i < sha256_digest_config<do_sha224>::numH; ++i) {
#ifdef __SYNTHESIS__
#pragma HLS unroll
#endif // __SYNTHESIS__
      uint32_t l = H[i];
      // XXX shift big endian to little endian.
      uint8_t t0 = (((l) >> 24) & 0xff);
      uint8_t t1 = (((l) >> 16) & 0xff);
      uint8_t t2 = (((l) >> 8) & 0xff);
      uint8_t t3 = (((l)) & 0xff);
      uint32_t l_little = ((uint32_t)t0) | (((uint32_t)t1) << 8) |
                          (((uint32_t)t2) << 16) | (((uint32_t)t3) << 24);
      hash_strm.write(l_little);
    }
  } else if (ow == 224) {
    ap_uint<224> w224;
  LOOP_SHA256_EMIT_OW224:
    for (short i = 0; i < sha256_digest_config<true>::numH; ++i) {
#ifdef __SYNTHESIS__
#pragma HLS unroll
#endif // __SYNTHESIS__
      uint32_t l = H[i];
      // XXX shift algorithm's big endian to HLS's little endian.
      uint8_t t0 = (((l) >> 24) & 0xff);
      uint8_t t1 = (((l) >> 16) & 0xff);
      uint8_t t2 = (((l) >> 8) & 0xff);
      uint8_t t3 = (((l)) & 0xff);
      uint32_t l_little = ((uint32_t)t0) | (((uint32_t)t1) << 8) |
                          (((uint32_t)t2) << 16) | (((uint32_t)t3) << 24);
      w224.range(32 * i + 31, 32 * i) = l_little;
    }
    hash_strm.write(w224);
  } else if (ow == 256) {
    ap_uint<256> w256;
  LOOP_SHA256_EMIT_OW256:
    for (short i = 0; i < sha256_digest_config<do_sha224>::numH; ++i) {
#ifdef __SYNTHESIS__
#pragma HLS unroll
#endif // __SYNTHESIS__
      uint32_t l = H[i];
      // XXX shift algorithm's big endian to HLS's little endian.
      uint8_t t0 = (((l) >> 24) & 0xff);
      uint8_t t1 = (((l) >> 16) & 0xff);
      uint8_t t2 = (((l) >> 8) & 0xff);
      uint8_t t3 = (((l)) & 0xff);
      uint32_t l_little = ((uint32_t)t0) | (((uint32_t)t1) << 8) |
                          (((uint32_t)t2) << 16) | (((uint32_t)t3) << 24);
      w256.range(32 * i + 31, 32 * i) = l_little;
    }
    hash_strm.write(w256);
  } else {
    // TODO
  }
} // sha256_digest

/// @brief SHA-256/224 implementation top.
/// @tparam do_sha224 the flag to calculate SHA224 instead of SHA256
/// @tparam msg_T the input message stream content type.
/// @tparam hash_T the input hash stream content type.
/// @param msg_strm the message being hashed.
/// @param len the message size in byte.
/// @param hash_strm the result.
template <bool do_sha224, typename msg_T, typename hash_T>
void sha256_top(hls::stream<msg_T>& msg_strm, uint64_t len,
                hls::stream<hash_T>& hash_strm) {
#ifdef __SYNTHESIS__
#pragma HLS DATAFLOW
#endif
  /// 512-bit Block stream
  hls::stream<hls_alg_internal::SHA256Block> blk_strm;
#ifdef __SYNTHESIS__
#pragma HLS STREAM variable = blk_strm depth = 4
#endif // __SYNTHESIS__

  // Generate block stream
  sha256_generate(msg_strm, blk_strm, len);

  // Digest block stream, and write hash stream.
  sha256_digest<do_sha224>(blk_strm, hash_strm, len);
} // sha256_top

} // namespace hls_alg_internal

namespace hls_alg {
/// @brief SHA-256 algorithm.
/// @tparam msg_T the input message stream content type.
/// @tparam hash_T the input hash stream content type.
/// @param msg_strm the message being hashed.
/// @param len the message size in byte.
/// @param hash_strm the result.
template <typename msg_T, typename hash_T>
HLS_DEPRECATED_FUNC(2022.1, xf::security::sha256 from Vitis Security)
void sha256(hls::stream<msg_T>& msg_strm, uint64_t len,
            hls::stream<hash_T>& hash_strm) {
  hls_alg_internal::sha256_top<false>(msg_strm, len, hash_strm);
}

/// @brief SHA-224 algorithm.
/// @tparam msg_T the input message stream content type.
/// @tparam hash_T the input hash stream content type.
/// @param msg_strm the message being hashed.
/// @param len the message size in byte.
/// @param hash_strm the result.
template <typename msg_T, typename hash_T>
HLS_DEPRECATED_FUNC(2022.1, xf::security::sha224 from Vitis Security)
void sha224(hls::stream<msg_T>& msg_strm, uint64_t len,
            hls::stream<hash_T>& hash_strm) {
  hls_alg_internal::sha256_top<true>(msg_strm, len, hash_strm);
}
} // namespace hls_alg

// Clean up macros.
#undef ROTR
#undef ROTL
#undef SHR
#undef CH
#undef MAJ
#undef BSIG0
#undef BSIG1
#undef SSIG0
#undef SSIG1

#undef _DEBUG_PRINT

#endif // ifndef _X_HLS_ALG_HASH_SHA224_SHA256_H_

// -*- cpp -*-
// vim: ts=8:sw=2:sts=2:ft=cpp


