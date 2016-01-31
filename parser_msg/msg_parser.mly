%{
 open Msg
%}

%token DEUX_PTS
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
    DEUX_PTS prefix SPACE cmd SPACE params { msg(Some($2),$4,Some($6)) }
  | cmd SPACE params                   { msg(None    ,$1,Some($3)) }
  | DEUX_PTS prefix SPACE cmd              { msg(Some($2),$4,None    ) }
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
  | DEUX_PTS STR         { [$2] }
  | STR SPACE params { $1::$3 }
;
