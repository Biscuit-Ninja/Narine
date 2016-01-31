(* Format d'un message standard *)

(* Pseudo BNF (source : http://abcdrfc.free.fr/rfc-vf/rfc1459.html#231)
<message> ::= [':' <préfixe> <espace> ] <command> <params> <crlf>
<préfixe> ::= <nom de serveur> | <pseudo> [ '!' <utilisateur> ] [ '@' <hôte> ]
<command> ::= <lettre> { <lettre> } | <nombre> <nombre> <nombre>
<espace> ::= ' ' { ' ' }
<params> ::= <espace> [ ':' <fin> | <milieu> <params> ]

<milieu> ::= <Toute séquence non vide d'octets à l'exclusion de ESPACE, NUL, CR, LF, le premier d'entre eux étant différent de ':'>
<fin> ::= <Toute suite, éventuellement vide, d'octets, à l'exception de NUL, CR et LF>
<crlf> ::= CR LF 
*)


type msg = prefix option * cmd * param list option

and prefix = string * string option * string option

and cmd =
| Cmd_str of string
| Cmd_int of int * int * int

and param = string
