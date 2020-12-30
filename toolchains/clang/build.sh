#!/bin/bash
# Copyright 2020 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -e

# This is a set of commands that build Clang+LLVM in a way that is more
# portable than the official binary distributions. There are three key
# differences:
#
# 1. The binaries were built on Ubuntu 16.04, which means they are built
#    against a fairly old glibc, which ensures that the binaries work on
#    old distributions.
# 2. LLVM_ENABLE_TERMINFO=OFF removes a shared library dependency to a
#    specific version of libtinfo that is not present by default on
#    Ubuntu 20.04 (it has a newer version).
# 3. libstdc++ and gcc_s are linked statically (only glibc is linked
#    dynamically).

sudo apt-get update
sudo apt install -y clang ninja-build cmake chrpath

# Download a recent Clang version. The one that ships with Ubuntu 16.04 is too old to build LLVM 10.
wget https://github.com/llvm/llvm-project/releases/download/llvmorg-10.0.1/clang+llvm-10.0.1-x86_64-linux-gnu-ubuntu-16.04.tar.xz
echo "48b83ef827ac2c213d5b64f5ad7ed082c8bcb712b46644e0dc5045c6f462c231  clang+llvm-10.0.1-x86_64-linux-gnu-ubuntu-16.04.tar.xz" | sha256sum -c
tar Jxf clang+llvm-10.0.1-x86_64-linux-gnu-ubuntu-16.04.tar.xz
CLANG_DIR=$(pwd)/clang+llvm-10.0.1-x86_64-linux-gnu-ubuntu-16.04/bin

wget https://github.com/llvm/llvm-project/releases/download/llvmorg-10.0.1/llvm-project-10.0.1.tar.xz
echo "82ce06e7c2b6a688dd0aa8f0aaa20f44850b1e692cf6c59bf7eebdc28440abea  llvm-project-10.0.1.tar.xz" | sha256sum -c
tar Jxf llvm-project-10.0.1.tar.xz

cd llvm-project-10.0.1/llvm/utils/release
tar Jxf ../../../../llvm-project-10.0.1.tar.xz
mkdir final
mv llvm-project-10.0.1 final/llvm-project
CC="$CLANG_DIR/clang" CXX="$CLANG_DIR/clang++" ./test-release.sh \
    -use-ninja -no-test-suite -release 10.0.1 -final \
    -triple x86_64-pc-linux-gnu -no-checkout \
    -configure-flags "-DLLVM_ENABLE_TERMINFO=OFF -DLLVM_STATIC_LINK_CXX_STDLIB=ON -DCMAKE_EXE_LINKER_FLAGS=-static-libgcc"
