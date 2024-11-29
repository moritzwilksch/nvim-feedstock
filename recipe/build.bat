@echo on
set "CMAKE_GENERATOR=Ninja"

cmake -S cmake.deps -B .deps -G Ninja -D CMAKE_BUILD_TYPE=Release -DUSE_BUNDLED=OFF -DUSE_BUNDLED_UV=ON || exit 1
cmake --build .deps || exit 1
cmake -S . -B build ^
    -G %CMAKE_GENERATOR% ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%" ^
    %CMAKE_ARGS% || exit 1
cmake --build build --config Release || exit 1

@REM cmake --install build fails with permission denied error
@REM we need to manually copy the files over
copy .\build\bin\nvim.exe %LIBRARY_PREFIX%\bin
copy .\build\bin\nvim.pdb %LIBRARY_PREFIX%\bin
copy .\build\windows_runtime_deps\cat.exe %LIBRARY_PREFIX%\bin
copy .\build\windows_runtime_deps\tee.exe %LIBRARY_PREFIX%\bin
copy .\build\windows_runtime_deps\win32yank.exe %LIBRARY_PREFIX%\bin
copy .\build\windows_runtime_deps\xxd.exe %LIBRARY_PREFIX%\bin
