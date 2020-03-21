#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

rm -rf build-linux-x86_64-debug
mkdir build-linux-x86_64-debug
pushd build-linux-x86_64-debug
cmake -DCMAKE_BUILD_TYPE=Debug ..
cmake --build .
popd

rm -rf build-linux-x86_64-release
mkdir build-linux-x86_64-release
pushd build-linux-x86_64-release
cmake -DCMAKE_BUILD_TYPE=Release ..
cmake --build .
popd

mkdir -p dist
cp build-linux-x86_64-release/bin/CyberAttack dist/CyberAttack-linux-x86_64
