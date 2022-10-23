Nginx Windows Build
===================

[![appveyor](https://ci.appveyor.com/api/projects/status/github/noproxy-http/nginx-windows?svg=true)](https://ci.appveyor.com/project/staticlibs/nginx-windows)

[Nginx](https://nginx.org/) build for Windows x86_64 with **NO MODIFICATIONS TO NGINX CODE** - [downloads](https://github.com/noproxy-http/nginx-windows/releases).

See vendor modifications to build scripts and resources in [vendor directory](https://github.com/noproxy-http/nginx-windows/tree/master/vendor).

The build includes a number of in-tree modules that roughly correspond to the [set of Nginx modules included in Fedora Linux](https://src.fedoraproject.org/rpms/nginx/blob/4c725813a0b4b4e8d5b8b386422dbec328b70df8/f/nginx.spec#_299).

How to build
------------

On Windows with [Visual Studio Community](https://visualstudio.microsoft.com/vs/community/) installed:

Get the sources of Nginx and its dependencies and additional build tools:

```
git clone https://github.com/noproxy-http/nginx-windows.git
cd nginx-windows
git submodule update --init
```

Run the build script specifying the full path to the `vcvars64.bat` script in your Visual Studio installation:

```
cmd /c scripts\build.bat "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat"
[...]
> Build completed successfully
```

Build with additional modules
-----------------------------

The [config script](https://github.com/noproxy-http/nginx-windows/blob/master/scripts/conf.sh#L16), besides containing a list of default nginx modules,
also scans the `nginx-windows/modules` directory adding every directory from there as an additional Nginx module.

For examples, to build Nginx including [Background Content Handler](https://github.com/noproxy-http/nginx-background-content-handler) module:

```
cd nginx-windows
cd modules
git clone https://github.com/noproxy-http/nginx-background-content-handler.git
cd ..
cmd /c scripts\build.bat "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat"
[...]
> adding module in ../../modules/nginx-background-content-handler
> + ngx_http_background_content_handler_module was configured
[...]
> Build completed successfully
```

Dev environment
---------------

The following command can be used to get a command line with the configured environment to be able to re-build Nginx multiple times:

```
cmd /c scripts\build.bat "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat" nossl
# wait for the build to finish
cmd /c scripts\build.bat "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat" nossl dev
[...]
> [vcvarsall.bat] Environment initialized for: 'x64'
uname -a
> MINGW32_NT-6.2 DESKTOP-NAME 1.0.11(0.46/3/2) 2009-07-11 17:46 i686 Msys
cd sources/nginx/
nmake
```

License information
-------------------

Build scripts and binaries in this project are released under the [Apache License 2.0](http://www.apache.org/licenses/LICENSE-2.0).
