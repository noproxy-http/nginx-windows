Nginx Windows Build
===================

[![appveyor](https://ci.appveyor.com/api/projects/status/github/noproxy-http/nginx-windows?svg=true)](https://ci.appveyor.com/project/staticlibs/nginx-windows)

[Nginx](https://nginx.org/) build for Windows x86_64 with **NO MODIFICATIONS TO NGINX CODE** - [downloads](https://github.com/noproxy-http/nginx-windows/releases).

See vendor modifications to build scripts and resources in [vendor directory](https://github.com/noproxy-http/nginx-windows/tree/master/vendor).

The build includes a number of in-tree modules that roughly correspond to the [set of Nginx modules included in Fedora Linux](https://src.fedoraproject.org/rpms/nginx/blob/4c725813a0b4b4e8d5b8b386422dbec328b70df8/f/nginx.spec#_299). Additionally the [NAXSI Web Application Firewall module](https://github.com/nbs-system/naxsi) is included.

How to build
------------

On Windows with [Visual Studio 2017 Community](https://stackoverflow.com/q/55837625) installed:

```
git clone --recursive https://github.com/noproxy-http/nginx-windows.git
cd nginx-windows
scripts\build.bat
```

To build the Nginx for Windows using different set of modules see configuration details in the [config script](https://github.com/noproxy-http/nginx-windows/blob/master/scripts/conf.sh#L16).

License information
-------------------

Build scripts in this project are released under the [Apache License 2.0](http://www.apache.org/licenses/LICENSE-2.0).

Binaries are released under the [GNU GPL v3](https://opensource.org/licenses/gpl-3.0.html), this is required by the [NAXSI module license](https://github.com/nbs-system/naxsi/blob/master/LICENSE).
