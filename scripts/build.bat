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

set BAD_SLASH_SCRIPT_DIR=%~dp0
set SCRIPT_DIR=%BAD_SLASH_SCRIPT_DIR:\=/%
set PROJECT_DIR=%SCRIPT_DIR%..

set VSCMD_DEBUG=1
set VSCMD_SKIP_SENDTELEMETRY=1

set NP_VCVARS64_PATH="C:/Program Files (x86)/Microsoft Visual Studio/2017/Community/VC/Auxiliary/Build/vcvars64.bat"
if not x == x%1 set NP_VCVARS64_PATH=%1

set NP_SSL_OPTS=ssl
if not x == x%2 set NP_SSL_OPTS=%2

set NP_DEV_OPTS=nodev
if not x == x%3 set NP_DEV_OPTS=%3

if not exist %NP_VCVARS64_PATH% (
  echo ERROR: Visual Studio installation not found: [%NP_VCVARS64_PATH%], please specify the full path to vcvars64.bat as a first argument.
  exit /b 1
)

call %NP_VCVARS64_PATH% || exit /b 1

set PATH=%PATH%;%PROJECT_DIR%/tools/msys/bin;%PROJECT_DIR%/tools/nasm;%PROJECT_DIR%/tools/perl/perl/bin

if not "dev" == "%NP_DEV_OPTS%" (
  call "%PROJECT_DIR%/tools/msys/bin/sh.exe" -c "%PROJECT_DIR%/scripts/build.sh"
) else (
  call "%PROJECT_DIR%/tools/msys/bin/sh.exe" -i -l
)
