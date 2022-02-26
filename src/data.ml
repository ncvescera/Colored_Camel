open GraphUtils;;
exception BadChoice of string;;

let exception_choise = BadChoice "L'id selezionato è inesistente !!";;

(* Grafo 1 *)
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
  let g = Grafo x in  (* Grafo effettivo *)

  (g, start, maxColors)
;;




(* Grafo 2 *)
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
    let maxColors = 3 in
    let g = Grafo x in  (* Grafo effettivo *)
    
    (g, start, maxColors)
;;

(* Grafo 2 *)
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
    let maxColors = 4 in
    let g = Grafo x in  (* Grafo effettivo *)
    
    (g, start, maxColors)
;;


let get_data data_id =
  let aux = function (*data id*)
     1 -> grafo_1 
    |2 -> grafo_2
    |3 -> grafo_2_err
    |_ -> raise exception_choise
  in aux data_id;; 