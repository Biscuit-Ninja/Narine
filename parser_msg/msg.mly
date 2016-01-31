%{
 open Msg
%}

%token 2PTS
%token EXCL
%token AT
%token EQ
%token EOF
%token EOL
%token SPACE
%token <int> INT
%token <string> STR

%start message
%type <msg> msg

  
%%


main:
    msg space EOL { $1 }
  | msg EOL       { $1 }
;

msg:
    2PTS prefix SPACE cmd SPACE params { msg(Some($2),$4,Some($6)) }
  | cmd SPACE params                   { msg(None    ,$1,Some($3)) }
  | 2PTS prefix SPACE cmd              { msg(Some($2),$4,None    ) }
  | cmd                                { msg(None    ,$1,None    ) }
;

prefix:
    STR EXCL STR AT STR { prefix($1,Some($3),Some($5)) }
  | STR EXCL STR        { prefix($1,Some($3),None    ) }
  | STR AT STR          { prefix($1,None    ,Some($3)) }
  | STR                 { prefix($1,None    ,None    ) }
;

cmd:
    STR { cmd(Cmd_str($1)) }
  | INT { cmd(Cmd_int(string_of_int $1)) }
;

params:
    STR              { [$1] }
  | 2PTS param_space { $2:: }
  | STR SPACE params { $1::$3 }
;

param_space:
    STR                   { $1 }
  | STR SPACE param_space { $1,$3 }
