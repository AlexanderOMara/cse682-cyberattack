#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

rm -rf build-windows-win64
mkdir build-windows-win64
pushd build-windows-win64
cmake -G "Visual Studio 17 Win64" ..
cmake --config Debug --build .
cmake --config Release --build .
popd

rm -rf build-windows-win32
mkdir build-windows-win32
pushd build-windows-win32
cmake -G "Visual Studio 17" ..
cmake --config Debug --build .
cmake --config Release --build .
popd

mkdir -p dist
find build-windows-win64
find build-windows-win32
# cp build-windows-win64-release/bin/CyberAttack.exe dist/CyberAttack-windows-win64.exe
# cp build-windows-win32-release/bin/CyberAttack.exe dist/CyberAttack-windows-win32.exe
