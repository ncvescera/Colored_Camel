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

(* Gestione dell'output *)
let reverse lista = List.rev lista;; (*potrebbe essere tolta dato che utilizzata sono in bf*)
let rec print_list =
        function
            [] -> print_string "\n"
            | x::rest -> print_int x; print_list rest



(* ------------------------------------------ *)



(* Dati *)

(* Grafo 1 *)
let x = function        (* Successori *)
      0 -> [1; 2]
    | 1 -> [0; 2; 3]
    | 2 -> [0; 1]
    | 3 -> [1; 4]
    | 4 -> [3]
    | 5 -> [6]
    | _ -> []
    ;;
let start = 3;;         (* Partenza *)
let grafo1 = Grafo x;;  (* Grafo effettivo *)

let n_nodi = conta_nodi grafo1 start;;  (* Numero di nodi raggiungibili dallo start *)
let colori = Array.make n_nodi (-1);;   (* Array di colori, struttura ausiliaria per vedere se un nodo ha un colore *)
                                        (* ogni posizione corrisponde al valore del nodo *)
                                        (* e.g. color.(0) -- colore del nodo 0 *)


(* Creo una lista di colorati che è la stessa di visited, poi quando esploro
    se il nodo non e' in visitati lo coloro e faccio colore ++ al prossimo ciclo
    se e' visitato lo coloro di 0, colore = 0 e continuo il ciclo.
 In paritca se e' già colorato ricomincio a colorare da 0 *)

(* ------------------------------------------ *)


(* Funzione principale *)
let main =
    print_string "nodi: "; print_int n_nodi; print_string "\n";

    let result = bf grafo1 start in 
    print_string "Nodi visitati: "; print_list result;;

main ;;