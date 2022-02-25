open Printer
open GraphUtils


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
let maxColors = 3;;
let grafo1 = Grafo x;;  (* Grafo effettivo *)

(* Grafo 2 *)
(*
let x = function        (* Successori *)
      0 -> [1; 2; 3; 4; 5]
    | 1 -> [0; 3]
    | 2 -> [0; 5; 4]
    | 3 -> [0; 1; 4]
    | 4 -> [0; 3; 2; 5]
    | 5 -> [0; 2; 4]
    | _ -> []
    ;;

    let start = 0;;         (* Partenza *)
    let maxColors = 3;;
    let grafo1 = Grafo x;;  (* Grafo effettivo *)

*)


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
    let res = colora grafo1 start maxColors in
    print_colori res;
    print_string "\n";;

main ;;