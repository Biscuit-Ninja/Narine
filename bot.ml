let fd = Irc.connect "irc.iiens.net" 6667;;
(*
print_newline ();;
print_string (input_line fd_in);; *)

Irc.init fd "Narine" "#narinetest";
Irc.run fd;
Irc.shutdown fd;

(*
Irc.shutdown fd;;
print_newline ();
*)
