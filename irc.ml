
let connect (server : string) (port : int) : Unix.file_descr =
  let s_descr = Unix.socket Unix.PF_INET Unix.SOCK_STREAM 0 in
  let addr = try (Unix.gethostbyname server)
    with exn -> failwith "gethosbyname" in
  let _ =
    try
      begin
	(*print_string "Connexion à irc.iiens.net\n";*)
	Unix.connect s_descr (Unix.ADDR_INET ((addr.Unix.h_addr_list).(0),6667) )
      end
    with exn -> Unix.close s_descr ; raise exn in
  s_descr

let key_pressed () =
  match input_line stdin with
    | "" -> false
    | str when str = "s" -> true
    | _ -> false


let receive (fdin : Unix.file_descr) : string =
  (*let buffer_size = 4096 in
  let buffer = String.create buffer_size in
  let rec copy () =
    match Unix.read fdin buffer 0 buffer_size with
      | 0 -> ()
      | n ->
	
	ignore (Unix.write fdout buffer 0 n);
	if key_pressed ()
	then ()
	else copy ()
  in copy ()
  *)
  let str = input_line fdin in
  print_string str;
  str

let send (fd : Unix.file_descr) (s : string) : unit =
  let l = String.length s in
  if (l < 4096)
  then
    ignore (Unix.write fd s 0 l)
  else
    ()

let pong (fd : Unix.file_descr) (msg : string) : unit =
  send
    fd
    (concat " " ["PONG";msg])
    
  
let init
    (fd : Unix.file_descr)
    (nick : string)
    (chan : string) : unit =
  let fd_out = Unix.out_channel_of_descr fd in
  begin

    (*send fd ("CAP LS");*)
    send fd ("Nick "^nick);
    send fd ("USER narine 0 * :NarineBot");
    (*output_string fd_out ("NICK "^nick);*)
    (*output_string fd_out ("USER Narinebot 0 * : OCaml IRC bot by BN");*)
    (*output_string fd_out ("JOIN "^chan);*)
    (*output_string fd_out ("PING 0"); *)
    ignore (receive fd);
    ignore (receive fd);
    ignore (receive fd);
    ignore (receive fd);
    ignore (receive fd);
    pong();
  end

let run (fd : Unix.file_descr) : unit =
  (*let fd_out = Unix.out_channel_of_descr fd in
  output_string fd_out "PRIVMSG #narinetest : Hello !";*)
  let continue = ref true in
  while (!continue) do
    if key_pressed ()
    then continue := false
    else ()
  done

let shutdown (fd : Unix.file_descr) : unit =
  begin
    (* print_string "Déconnexion..\n"; *)
    Unix.shutdown fd Unix.SHUTDOWN_SEND;
    (* print_string "Bye.\n\n" *)
  end
