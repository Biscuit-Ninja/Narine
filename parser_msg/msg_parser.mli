type token =
  | DEUX_PTS
  | EXCL
  | AT
  | EQ
  | EOF
  | EOL
  | SPACE
  | INT of (int)
  | STR of (string)

val main :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> msg
