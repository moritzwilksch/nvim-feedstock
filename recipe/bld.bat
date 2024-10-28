@echo off
setlocal enabledelayedexpansion
set "PATH=%CONDA_PREFIX%\Library\bin;%CONDA_PREFIX%\Library\usr\bin;%PATH%"
set "CMAKE_GENERATOR=Ninja"


cmake -S . -B build ^
    -G %CMAKE_GENERATOR% ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DUSE_BUNDLED=OFF ^
    -DLIBUV_LIBRARY="%PREFIX%\lib\libuv.dll" ^
    -DLPEG_LIBRARY="%PREFIX%\lib\liblpeg.dll" ^
    %CMAKE_ARGS%
cmake --build build --config Release
cmake --install build

