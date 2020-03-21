#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

rm -rf build-mac-debug
mkdir build-mac-debug
pushd build-mac-debug
cmake -DCMAKE_BUILD_TYPE=Debug ..
cmake --build .
popd

rm -rf build-mac-release
mkdir build-mac-release
pushd build-mac-release
cmake -DCMAKE_BUILD_TYPE=Release ..
cmake --build .
popd

mkdir -p dist
cp build-mac-release/bin/CyberAttack dist/CyberAttack-mac
