type grafo = Grafo of (int -> int list);;

let x = function
      0 -> [1; 2]
    | 1 -> [0; 2; 3]
    | 2 -> [0; 1]
    | 3 -> [1; 4]
    | 4 -> [3]
    | 5 -> [6]
    | _ -> []
    ;;

(*grafo sconnesso*)
(*
let x = function
      0 -> [1; 2]
    | 1 -> [0; 2; 3]
    | 2 -> [0; 1]
    | 3 -> [1; 4]
    | 4 -> [3]
    | 5 -> [6]
    | _ -> []
    ;;
*)

let grafo1 = Grafo x;;


let reverse lista = List.rev lista;; (*potrebbe essere tolta dato che utilizzata sono in bf*)
let rec print_list =
        function
            [] -> print_string "\n"
            | x::rest -> print_int x; print_list rest


(* ritorna una lista con tutti i nodi esplorati*)
let bf (Grafo succ) start =
    let rec search visited = function
        [] -> visited
        | node::tail ->    if List.mem node visited then search visited tail
                        else search (node::visited) (tail@(succ node))
    in reverse (search [] [start]);; (*la lista viene data al contrario quindi la inverto*)





let main =
    let result = bf grafo1 0 in 
    print_list result;;

main ;;