(* Fichier prog.ml *)
open Msg (* Seulement si des fonctions d'affichage (pour les tests) sont présentes. *)

(* Fonction principale (équivalent du main en C). *)
let _ =
  (* let lexbuf = Lexing.from_channel (open_in "Pascal.p") in *) (* Le code Pascal se trouve dans le fichier Pascal.p *)
  let lexbuf = Lexing.from_string ":irc.iiens.net NOTICE AUTH :*** Looking up your hostname...\n\r" in
let result = Parser.main Lexer.token lexbuf in () 
