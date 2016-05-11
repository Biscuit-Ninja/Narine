
(* connect to the irssi server *)
(* - server -> string : is the DNS of the server *)
(* - port -> int : is the port *)
val connect : string -> int -> Unix.file_descr

(* Get a message from the irssi server *)
val receive : Unix.file_descr -> Unix.file_descr -> unit

(* Send information to the server to identify the bot *)
val init : Unix.file_descr -> string -> string -> unit

(* Run the core of the bot *)
val run : Unix.file_descr -> unit

(* shutdown the connection *)
val shutdown : Unix.file_descr -> unit
