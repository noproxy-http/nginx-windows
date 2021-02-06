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
pushd ./sources/openssl
git reset --hard HEAD && git clean -dxf
popd
pushd ./sources/pcre
git reset --hard HEAD && git clean -dxf
popd
pushd ./sources/zlib
git reset --hard HEAD && git clean -dxf
popd

# nginx
pushd ./sources/nginx
git reset --hard HEAD && git clean -dxf

# adjustments
rm ./auto/lib/openssl/makefile.msvc
cp "${PROJECT_DIR}"/scripts/makefile.msvc ./auto/lib/openssl/
if [ -f ../../vendor/icon.ico ]; then
    rm ./src/os/win32/nginx.ico
    cp ../../vendor/icon.ico ./src/os/win32/nginx.ico
fi

# build
./auto/configure \
    --with-cc=cl \
    --with-cc-opt=-DFD_SETSIZE=1024 \
    --builddir=objs \
    --prefix= \
    --conf-path=conf/nginx.conf \
    --pid-path=logs/nginx.pid \
    --http-log-path=logs/access.log \
    --error-log-path=logs/error.log \
    --sbin-path=nginx.exe \
    --http-client-body-temp-path=temp/client_body_temp \
    --http-proxy-temp-path=temp/proxy_temp \
    --http-fastcgi-temp-path=temp/fastcgi_temp \
    --http-scgi-temp-path=temp/scgi_temp \
    --http-uwsgi-temp-path=temp/uwsgi_temp \
    --with-openssl=../openssl \
    --with-pcre=../pcre \
    --with-zlib=../zlib \
    --with-select_module  \
    --with-poll_module \
    --with-ipv6 \
    --with-http_ssl_module \
    --with-http_v2_module \
    --with-http_realip_module \
    --with-http_addition_module \
    --with-http_sub_module \
    --with-http_dav_module \
    --with-http_flv_module \
    --with-http_mp4_module \
    --with-http_gunzip_module \
    --with-http_gzip_static_module \
    --with-http_random_index_module \
    --with-http_secure_link_module \
    --with-http_slice_module \
    --with-http_stub_status_module \
    --with-http_auth_request_module \
    --with-pcre \
    --with-stream \
    --with-stream_ssl_module \
    --with-stream_ssl_preread_module \
    --add-module=../../modules/nginx-background-content-handler

nmake
popd

# dist
rm -rf build
mkdir ./build
mkdir ./build/dist
mkdir ./build/dist/temp
mkdir ./build/dist/logs
cp ./sources/nginx/objs/nginx.exe ./build/dist/
cp -r ./sources/nginx/conf ./build/dist/
rm ./build/dist/conf/nginx.conf
cp ./scripts/nginx.conf ./build/dist/conf/

echo "Build completed successfully"
