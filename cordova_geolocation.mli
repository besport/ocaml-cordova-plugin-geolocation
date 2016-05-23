(* -------------------------------------------------------------------------- *)
(* FIXME
 * All types are set to 'a option because during tests (nexus 5, android 6.0.1),
 * some values were null and where sent to null.
 * AltitudeAccuracy: not supported on android devices and Amazon Fire OS. Set
 * null in these cases.
 *)
class coordinates : Ojs.t ->
  object
    inherit Ojs.obj
    method latitude            : float option
    method longitude           : float option
    method altitude            : float option
    method accuracy            : float option
    method altitude_accuracy   : float option
    method heading             : float option
    method speed               : float option
  end

(* A timestamp is just an integer *)
class position : Ojs.t ->
  object
    inherit Ojs.obj
    method coords              : coordinates
    method timestamp           : int
  end
(* -------------------------------------------------------------------------- *)

(* -------------------------------------------------------------------------- *)
(* Types and functions related to errors *)
(* position_error contains a properties called 'code' which is a 1 2 or 3 ie a
 * int. For the binding, we need to use an integer but we provide a
 * position_error type and a function taking the integer returned by the error
 * whic returns the corresping value for the ocaml type. *)
type position_error_code =
  | Permission_denied [@js 1]
  | Position_unavailable [@js 2]
  | Timeout [@js 3]
  [@@js.enum]

class position_error : Ojs.t ->
  object
    inherit Ojs.obj
    method code      : position_error_code
    method message   : string
  end
(* -------------------------------------------------------------------------- *)

(* -------------------------------------------------------------------------- *)
class options : Ojs.t ->
  object
    inherit Ojs.obj
    method enable_high_accuracy       : bool
    method timeout                    : int
    method maximum_age                : int
  end

val create_options :
  ?enable_high_accuracy:(bool [@js.default true]) ->
  ?timeout:(int [@js.default 5000])               ->
  ?maximum_age:(int [@js.default 3000])           ->
  unit                                            ->
  options
[@@js.builder]
(* -------------------------------------------------------------------------- *)

(* -------------------------------------------------------------------------- *)
class geolocation : Ojs.t ->
  object
    inherit Ojs.obj
    method get_current_position : (position -> unit)        ->
                                  (position_error -> unit)  ->
                                  options                   ->
                                  unit
    method watch_position       : (position -> unit)        ->
                                  (position_error -> unit)  ->
                                  options                   ->
                                  int
    method clear_watch          : int                       ->
                                  unit
  end
(* -------------------------------------------------------------------------- *)

(* -------------------------------------------------------------------------- *)
val t : unit -> geolocation
[@@js.get "navigator.geolocation"]
(* -------------------------------------------------------------------------- *)
