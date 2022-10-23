#!/bin/sh
#
# Copyright 2021, alex at staticlibs.net
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

set -e
set -x

# deps
pushd "${PROJECT_DIR}"/sources/openssl
git reset --hard HEAD && git clean -dxf
popd
pushd "${PROJECT_DIR}"/sources/pcre
git reset --hard HEAD && git clean -dxf
popd
pushd "${PROJECT_DIR}"/sources/pcre2
git reset --hard HEAD && git clean -dxf
popd
pushd "${PROJECT_DIR}"/sources/zlib
git reset --hard HEAD && git clean -dxf
popd

# nginx
pushd "${PROJECT_DIR}"/sources/nginx
git reset --hard HEAD && git clean -dxf

# adjustments
rm ./auto/lib/openssl/makefile.msvc
cp "${PROJECT_DIR}"/vendor/makefile.msvc ./auto/lib/openssl/
rm ./src/os/win32/nginx.ico
cp "${PROJECT_DIR}"/vendor/icon.ico ./src/os/win32/nginx.ico

# configure
if [ "nossl" == "${NP_SSL_OPTS}" ] ; then
  sh "${PROJECT_DIR}"/scripts/conf-nossl.sh
else
  sh "${PROJECT_DIR}"/scripts/conf.sh
fi
   
# build
nmake

popd

# dist
rm -rf build
mkdir "${PROJECT_DIR}"/build
mkdir "${PROJECT_DIR}"/build/dist
mkdir "${PROJECT_DIR}"/build/dist/temp
mkdir "${PROJECT_DIR}"/build/dist/logs
cp "${PROJECT_DIR}"/sources/nginx/objs/nginx.exe "${PROJECT_DIR}"/build/dist/
cp -r "${PROJECT_DIR}"/sources/nginx/conf "${PROJECT_DIR}"/build/dist/
rm "${PROJECT_DIR}"/build/dist/conf/nginx.conf
cp "${PROJECT_DIR}"/vendor/nginx.conf "${PROJECT_DIR}"/build/dist/conf/

echo "Build completed successfully"
