#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

rm -rf build-windows-win64
mkdir build-windows-win64
pushd build-windows-win64
cmake -A x64 ..
cmake --build . --config Debug
cmake --build . --config Release
popd

rm -rf build-windows-win32
mkdir build-windows-win32
pushd build-windows-win32
cmake -A Win32 ..
cmake --build . --config Debug
cmake --build . --config Release
popd

mkdir -p dist
find build-windows-win64
find build-windows-win32
# cp build-windows-win64-release/bin/CyberAttack.exe dist/CyberAttack-windows-win64.exe
# cp build-windows-win32-release/bin/CyberAttack.exe dist/CyberAttack-windows-win32.exe
