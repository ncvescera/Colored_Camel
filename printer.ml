let reverse lista = List.rev lista;; (*potrebbe essere tolta dato che utilizzata sono in bf*)
let rec print_list =
        function
            [] -> print_string "\n"
            | x::rest -> print_int x; print_list rest