
val connect : string -> int -> Unix.file_descr

val receive : Unix.file_descr -> Unix.file_descr -> unit

val init : Unix.file_descr -> string -> string -> unit

val run : Unix.file_descr -> unit

val shutdown : Unix.file_descr -> unit
