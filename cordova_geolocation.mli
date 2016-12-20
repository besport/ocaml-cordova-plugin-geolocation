(* -------------------------------------------------------------------------- *)
(* FIXME
 * All types are set to 'a option because during tests (nexus 5, android 6.0.1),
 * some values were null and were sent to null.
 * AltitudeAccuracy: not supported on android devices and Amazon Fire OS. Set
 * null in these cases.
 *)
type coordinates = private Ojs.t

val latitude            : coordinates -> float option
[@@js.get "latitude"]
val longitude           : coordinates -> float option
[@@js.get "longitude"]
val altitude            : coordinates -> float option
[@@js.get "altitude"]
val accuracy            : coordinates -> float option
[@@js.get "accuracy"]
val altitude_accuracy   : coordinates -> float option
[@@js.get "altitudeAccuracy"]
val heading             : coordinates -> float option
[@@js.get "heading"]
val speed               : coordinates -> float option
[@@js.get "speed"]
(* -------------------------------------------------------------------------- *)

(* -------------------------------------------------------------------------- *)
type position = private Ojs.t

val coords : position -> coordinates
[@@js.get "coords"]

(* A timestamp is just an integer *)
val timestamp : position -> int
[@@js.get "timestamp"]
(* -------------------------------------------------------------------------- *)

(* -------------------------------------------------------------------------- *)
(* Types and functions related to errors *)
(* position_error contains a properties called 'code' which is a 1 2 or 3 ie a
 * int. For the binding, we need to use an integer but we provide a
 * position_error type and a function taking the integer returned by the error
 * whic returns the corresping value for the ocaml type. *)

type position_error = private Ojs.t

type position_error_code =
  | Permission_denied [@js 1]
  | Position_unavailable [@js 2]
  | Timeout [@js 3]
  [@@js.enum]

val position_error_code : position_error -> position_error_code
[@@js.get "code"]

val position_error_message : position_error -> string
[@@js.get "message"]
(* -------------------------------------------------------------------------- *)

(* -------------------------------------------------------------------------- *)
type options = private Ojs.t

val create_options :
  ?enable_high_accuracy:(bool [@js.default true])       ->
  ?timeout:(int [@js.default 5000])                     ->
  ?maximum_age:(int [@js.default 3000])                 ->
  unit                                                  ->
  options
[@@js.builder]
(* -------------------------------------------------------------------------- *)

(* -------------------------------------------------------------------------- *)
val get_current_position :
  (position -> unit)                                    ->
  (position_error -> unit)                              ->
  ?options:(options [@js.default create_options ()])    ->
  unit                                                  ->
  unit
[@@js.global "navigator.geolocation.getCurrentPosition"]

val watch_position :
  (position -> unit)                                    ->
  (position_error -> unit)                              ->
  ?options:(options [@js.default create_options ()])    ->
  unit                                                  ->
  int
[@@js.global "navigator.geolocation.watchPosition"]

val clear_watch :
  int                                                   ->
  unit
[@@js.global "navigator.geolocation.clearWatch"]
(* -------------------------------------------------------------------------- *)
