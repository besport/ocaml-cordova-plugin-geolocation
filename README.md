# ocaml-cordova-plugin-geolocation

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

## How to use ?

* TODO

## ! BE CAREFUL !

The plugin creates a new object called *navigator.geolocation*, but the object is
available when the *deviceready* event is handled.

We provide a function *Geolocation.t* of type *unit -> geolocation* which creates the
binding to the *navigator.geolocation* object. You must call it when the deviceready
event is handled, eg (with js_of_ocaml)

```OCaml
let on_device_ready _ =
  let geolocation = Geolocation_cordova.t () in
  (* Some code *)

let _ =
  Dom.addEventListener Dom_html.document (Dom.Event.make "deviceready")
  (Dom_html.handler on_device_ready) Js._false
```
