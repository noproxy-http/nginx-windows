Nginx Windows Build
===================

[![appveyor](https://ci.appveyor.com/api/projects/status/github/noproxy-http/nginx-windows?svg=true)](https://ci.appveyor.com/project/staticlibs/nginx-windows)

[Nginx](https://nginx.org/) build for Windows x86_64 with **NO MODIFICATIONS TO NGINX CODE** - [downloads](https://github.com/noproxy-http/nginx-windows/releases).

See vendor modifications to build scripts and resources in [vendor directory](https://github.com/noproxy-http/nginx-windows/tree/master/vendor).

The build includes a number of in-tree modules that roughly correspond to the [set of Nginx modules included in Fedora Linux](https://src.fedoraproject.org/rpms/nginx/blob/4c725813a0b4b4e8d5b8b386422dbec328b70df8/f/nginx.spec#_299).

How to build
------------

On Windows with [Visual Studio Community](https://visualstudio.microsoft.com/vs/community/) installed:

```
git clone https://github.com/noproxy-http/nginx-windows.git
cd nginx-windows
git submodule update --init
scripts\build.bat
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
scripts\build.bat
[...]
> adding module in ../../modules/nginx-background-content-handler
> + ngx_http_background_content_handler_module was configured
[...]
```

License information
-------------------

Build scripts and binaries in this project are released under the [Apache License 2.0](http://www.apache.org/licenses/LICENSE-2.0).