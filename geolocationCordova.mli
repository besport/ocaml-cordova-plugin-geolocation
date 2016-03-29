(* -------------------------------------------------------------------------- *)
type watch_id
(* -------------------------------------------------------------------------- *)

(* -------------------------------------------------------------------------- *)
(* FIXME
 * All types are set to 'a Js.opt because during tests (nexus 5, android 6.0.1),
 * some values were null and where sent to null.
 * Use Js.Opt.to_option c##prop to convert to option type and match ... with.
 * See the example.
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
    method altitudeAccuracy    : float option
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
[@@@js.stop]
type position_error_code
val position_error_code_to_value : int -> position_error_code
[@@@js.start]

[@@@js.implem
type position_error_code =
  | Permission_denied
  | Position_unavailable
  | Timeout
  | Unknown

let position_error_code_to_value c = match c with
  | 1 -> Permission_denied
  | 2 -> Position_unavailable
  | 3 -> Timeout
  | _ -> Unknown
]

class position_error : Ojs.t ->
  object
    inherit Ojs.obj
    method code      : int
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
    method get_current_position : (position -> unit) ->
                                  (position_error -> unit) ->
                                  options ->
                                  unit
    method watch_position       : (position -> unit) ->
                                  (position_error -> unit) ->
                                  options ->
                                  int
    method clear_watch          : watch_id ->
                                  unit
  end
(* -------------------------------------------------------------------------- *)

(* -------------------------------------------------------------------------- *)
val t : unit -> geolocation
[@@js.get "navigator.geolocation"]
(* -------------------------------------------------------------------------- *)
