# ocaml-cordova-plugin-geolocation

[![LGPL-v3 licensed](https://img.shields.io/badge/license-LGPLv3-blue.svg)](https://raw.githubusercontent.com/dannywillems/ocaml-cordova-plugin-geolocation/master/LICENSE)
[![Build Status](https://travis-ci.org/dannywillems/ocaml-cordova-plugin-geolocation.svg?branch=master)](https://travis-ci.org/dannywillems/ocaml-cordova-plugin-geolocation)

Binding to
[cordova-plugin-geolocation](https://github.com/apache/cordova-plugin-geolocation)

[Example
application](https://github.com/dannywillems/ocaml-cordova-plugin-geolocation-example).

## What does cordova-plugin-geolocation do ?

```
This plugin provides information about the device's location, such as latitude
and longitude. Common sources of location information include Global Positioning
System (GPS) and location inferred from network signals such as IP address,
RFID, WiFi and Bluetooth MAC addresses, and GSM/CDMA cell IDs. There is no
guarantee that the API returns the device's actual location.

This API is based on the W3C Geolocation API Specification, and only executes on
devices that don't already provide an implementation.
```

Source: [cordova-plugin-geolocation](https://github.com/apache/cordova-plugin-geolocation)

## Repository branches and tags

We are migrating bindings from
[js_of_ocaml](https://github.com/ocsigen/js_of_ocaml) (low level bindings) to
[gen_js_api](https://github.com/lexifi/gen_js_api) (high level bindings).

The gen_js_api binding allows to use *pure* ocaml types (you don't have to use
the ## syntax from js_of_ocaml or Js.string type but only # and string type).

The js_of_ocaml version is available in the branch
[*js_of_ocaml*](https://github.com/dannywillems/ocaml-cordova-plugin-geolocation/tree/js_of_ocaml)
but we **recommend** to use the gen_js_api version which is the master branch.

## How to install and compile your project by using this plugin ?

Don't forget to switch to a compiler **>= 4.03.0**.
```Shell
opam switch 4.03.0
```

You can use opam by pinning the repository with
```Shell
opam pin add cordova-plugin-geolocation https://github.com/dannywillems/ocaml-cordova-plugin-geolocation.git
```

and to compile your project, use
```Shell
ocamlfind ocamlc -c -o [output_file] -package gen_js_api -package cordova-plugin-geolocation [...] -linkpkg [other arguments]
```

Don't forget to install the cordova plugin geolocation with
```Shell
cordova plugin add cordova-plugin-geolocation
```

## How to use ?

See the official documentation:
[cordova-plugin-geolocation](https://github.com/apache/cordova-plugin-geolocation)
