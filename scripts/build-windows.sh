#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

rm -rf build-windows-win64-debug
mkdir build-windows-win64-debug
pushd build-windows-win64-debug
cmake -DCMAKE_GENERATOR_PLATFORM=x64 -DCMAKE_BUILD_TYPE=Debug ..
cmake --config Debug --build .
popd

rm -rf build-windows-win64-release
mkdir build-windows-win64-release
pushd build-windows-win64-release
cmake -DCMAKE_GENERATOR_PLATFORM=x64 -DCMAKE_BUILD_TYPE=Release ..
cmake --config Release --build .
popd

rm -rf build-windows-win32-debug
mkdir build-windows-win32-debug
pushd build-windows-win32-debug
cmake -DCMAKE_GENERATOR_PLATFORM=x86 -DCMAKE_BUILD_TYPE=Debug ..
cmake --config Debug --build .
popd

rm -rf build-windows-win32-release
mkdir build-windows-win32-release
pushd build-windows-win32-release
cmake -DCMAKE_GENERATOR_PLATFORM=x86 -DCMAKE_BUILD_TYPE=Release ..
cmake --config Release --build .
popd

mkdir -p dist
cp build-windows-win64-release/bin/CyberAttack.exe dist/CyberAttack-windows-win64.exe
cp build-windows-win32-release/bin/CyberAttack.exe dist/CyberAttack-windows-win32.exe
