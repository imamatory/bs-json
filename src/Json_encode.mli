(** Provides functions for encoding a JSON data structure *)

type 'a encoder = 'a -> Js.Json.t
(** The type of a encoder combinator *)

external null : Js.Json.t = "" [@@bs.val]
(** [null] is the singleton null JSON value *)

external string : string -> Js.Json.t = "%identity"
(** [string s] makes a JSON string of the [string] [s] *)

external float : float -> Js.Json.t = "%identity"
(** [float n] makes a JSON number of the [float] [n] *)

external int : int -> Js.Json.t = "%identity"
(** [int n] makes a JSON number of the [int] [n] *)

external boolean : Js.boolean -> Js.Json.t = "%identity" 
(** [boolean b] makes a JSON boolean of the [Js.boolean] [b] *)

val bool : bool -> Js.Json.t
(** [bool b] makes a JSON boolean of the [bool] [b]*) 

val nullable : 'a encoder -> 'a option -> Js.Json.t
(** [nullable encoder option] returns either the encoded value or [Js.Json.null]*)

val withDefault : Js.Json.t -> 'a encoder -> 'a option -> Js.Json.t
(** [withDefault default encoder option] returns the encoded value if present, oterwise [default]*)

val pair : 'a encoder -> 'b encoder -> ('a * 'b) -> Js.Json.t
(** [pair encoder encoder tuple] creates a JSON array from a tuple of size 2*)

external dict : Js.Json.t Js_dict.t -> Js.Json.t = "%identity"
(** [dict d] makes a JSON object of the [Js.Dict.t] [d] *)

val object_ : (string * Js.Json.t) list -> Js.Json.t
(** [object_ props] makes a JSON objet of the [props] list of properties *)

external array : Js.Json.t array -> Js.Json.t = "%identity"
[@@deprecated "Use `jsonArray` instead"]
(** [array a] makes a JSON array of the [Js.Json.t array] [a] 
 *  @deprecated Use [jsonArray] instead.
 *)

val arrayOf : 'a encoder -> 'a array encoder
(** [arrayOf encoder l] makes a JSON array of the [list] [l] using the given [encoder] 
 *  NOTE: This will be renamed `array` once the existing and deprecated `array` function
 *  has been removed.
 *)

val list : 'a encoder -> 'a list encoder
(** [list encoder a] makes a JSON array of the [array] [a] using the given [encoder] *)

(** The functions below are specialized for specific array type which 
    happened to be already JSON object in the BuckleScript runtime. Therefore
    they are more efficient (constant time rather than linear conversion). *) 

external jsonArray : Js.Json.t array -> Js.Json.t = "%identity"
(** [jsonArray a] makes a JSON array of the [Js.Json.t array] [a] *)

external stringArray : string array -> Js.Json.t = "%identity"
(** [stringArray a] makes a JSON array of the [string array] [a] *) 

external numberArray : float array -> Js.Json.t = "%identity"
(** [numberArray a] makes a JSON array of the [float array] [a] *)

external booleanArray : Js.boolean array -> Js.Json.t = "%identity"
(** [booleanArray] makes a JSON array of the [Js.boolean array] [a] *)
