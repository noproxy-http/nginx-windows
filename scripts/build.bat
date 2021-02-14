@echo off
rem
rem Copyright 2021, alex at staticlibs.net
rem
rem Licensed under the Apache License, Version 2.0 (the "License");
rem you may not use this file except in compliance with the License.
rem You may obtain a copy of the License at
rem
rem http://www.apache.org/licenses/LICENSE-2.0
rem
rem Unless required by applicable law or agreed to in writing, software
rem distributed under the License is distributed on an "AS IS" BASIS,
rem WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
rem See the License for the specific language governing permissions and
rem limitations under the License.
rem

@echo on

set BAD_SLASH_SCRIPT_DIR=%~dp0
set SCRIPT_DIR=%BAD_SLASH_SCRIPT_DIR:\=/%
set PROJECT_DIR=%SCRIPT_DIR%..

set PATH=%PATH%;%PROJECT_DIR%/tools/msys/bin;%PROJECT_DIR%/tools/nasm;%PROJECT_DIR%/tools/perl/perl/bin

call "C:/Program Files (x86)/Microsoft Visual Studio/2017/Community/VC/Auxiliary/Build/vcvars64.bat"

@echo on
pushd "%PROJECT_DIR%/modules/nginx-background-content-handler/test" || exit /b 1
if exist build rd /s /q build
mkdir build || exit /b 1
popd || exit /b 1
pushd "%PROJECT_DIR%/modules/nginx-background-content-handler/test/build" || exit /b 1
cmake .. -G "NMake Makefiles" || exit /b 1
nmake || exit /b 1
popd || exit /b 1

call "%PROJECT_DIR%/tools/msys/bin/sh.exe" -c "%PROJECT_DIR%/scripts/build.sh"
