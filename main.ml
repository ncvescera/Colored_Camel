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




let bf (Grafo succ) start =
    let rec search visited = function
        [] -> visited
        | a::rest ->    if List.mem a visited then search visited rest
                        else search (a::visited) (rest@(succ a))
    in search [] [start];; (*non ho idea di come funzioni sta cosa*)


let rec print_list = function
    [] -> print_string "\n"
    | a::rest -> print_int a; print_list rest;;


let reverse lista = List.rev lista;;


let result = bf grafo1 0;;
print_list (reverse result);;