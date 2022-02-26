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
let maxColors = 3;;     (* Massimo numero di colori*)
let grafo1 = Grafo x;;  (* Grafo effettivo *)

(* Grafo 2 *)
(* con numero di Colori insufficienti *)
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

(* Grafo 2 *)
(* con numero di Colori giusti *)
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
    let maxColors = 4;;
    let grafo1 = Grafo x;;  (* Grafo effettivo *)
*)


(* Funzione principale *)
let main =
    let res = colora grafo1 start maxColors in
    print_colori res
;;

main ;;