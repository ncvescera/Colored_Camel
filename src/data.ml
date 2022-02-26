open GraphUtils;;
exception BadChoice of string;;

let exception_choise = BadChoice "L'id selezionato è inesistente !!";;

(*Grafo 1 *)
let grafo_1 =
  let x = function        (* Successori *)
        0 -> [1; 2]
      | 1 -> [0; 2; 3]
      | 2 -> [0; 1]
      | 3 -> [1; 4]
      | 4 -> [3]
      | 5 -> [6]
      | _ -> [] in
  let start = 3 in         (* Partenza *)
  let maxColors = 3 in     (* Massimo numero di colori*)
  let g = Grafo x in       (* Grafo effettivo *)

  (g, start, maxColors)
;;




(*Grafo 2 *)
(* con numero di Colori insufficienti *)
let grafo_2_err = 
  let x = function        (* Successori *)
        0 -> [1; 2; 3; 4; 5]
      | 1 -> [0; 3]
      | 2 -> [0; 5; 4]
      | 3 -> [0; 1; 4]
      | 4 -> [0; 3; 2; 5]
      | 5 -> [0; 2; 4]
      | _ -> [] in

    let start = 0 in         (* Partenza *)
    let maxColors = 3 in     (* Massimo numero di colori*)
    let g = Grafo x in       (* Grafo effettivo *)
    
    (g, start, maxColors)
;;

(*Grafo 2 *)
(* con numero di Colori giusti *)
let grafo_2 = 
  let x = function        (* Successori *)
        0 -> [1; 2; 3; 4; 5]
      | 1 -> [0; 3]
      | 2 -> [0; 5; 4]
      | 3 -> [0; 1; 4]
      | 4 -> [0; 3; 2; 5]
      | 5 -> [0; 2; 4]
      | _ -> [] in

    let start = 0 in         (* Partenza *)
    let maxColors = 4 in     (* Massimo numero di colori*)
    let g = Grafo x in       (* Grafo effettivo *)
    
    (g, start, maxColors)
;;


(*Permette di scegliere un grafo tra quelli di default*)
(* Ogni grafo ha un id. Dato questo id ritorna il grafo:
    
    Grafo g, partenza, maxColori dove

    Grafo g:    Grafo (funzione successori)
    partenza:   nodo da cui partire
    maxColori:  numero massimo di colori da utilizzare per la colorazione

  input:
    id_grafo: Id del grafo che si vuole scegliere
*)
let scegli_grafo id_grafo =
  let aux = function (*grafo id*)
     1 -> grafo_1 
    |2 -> grafo_2
    |3 -> grafo_2_err
    |_ -> raise exception_choise
  in aux id_grafo;; 