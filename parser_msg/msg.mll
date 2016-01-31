
{
open Parser
}

rule token = parse
| ':'                    {2PTS}
| ':-'                   {2PTS_TRAIT}
| '!'                    {EXCL}
| '@'                    {AT}
| '='                    {EQ}
| '\n\r'                 {EOL}
| [' ' '\n' '\t' eof]+	 { token lexbuf }
| ['0'-'9']+  as i       {INT (int_of_string i)}
| ['A'-'Z' 'a'-'z'] ['A'-'Z' 'a'-'z' '0'-'9']* as lxm {STR lxm}
