(* Strutture dati ed eccezioni *)
type grafo = Grafo of (int -> int list);;
exception BadGraphCostruction;;

(* ------------------------------------------ *)


(* ritorna una lista con tutti i nodi esplorati*)
let bf (Grafo succ) start =
    let rec search visited = function
        [] -> visited
        | node::tail -> if List.mem node visited 
                            then search visited tail
                        else search (visited@[node]) (tail@(succ node))
    in search [] [start];;



(* ------------------------------------------ *)

(* Conta il numero di nodi raggiungibili dallo start del grafo *)
let conta_nodi (Grafo g) start = List.length (bf (Grafo g) start);;

(* il grafo deve partire da 0 [forse inutile]*)
let check_grafo (Grafo g) = 
    if g 0 = [] 
        then raise BadGraphCostruction
    else true;;

(* ------------------------------------------ *)