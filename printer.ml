let reverse lista = List.rev lista;; (*potrebbe essere tolta dato che utilizzata sono in bf*)
let rec print_list =
        function
            [] -> print_string "\n"
            | x::rest -> print_int x; print_list rest;;

let rec print_colori = function
  [] -> print_string "\n"
  | (x, y)::rest -> 
      print_string "Nodo: "; print_int x;
      print_string " color: "; print_int y; print_string "\n";
      print_colori rest;;