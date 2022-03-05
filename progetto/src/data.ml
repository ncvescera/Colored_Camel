open GraphUtils;;
exception BadChoice;;








(*Grafo 1 *)
let grafo_1 =
  let x = function        
        0 -> [1; 2]
      | 1 -> [0; 2; 3]
      | 2 -> [0; 1]
      | 3 -> [1; 4]
      | 4 -> [3]
      | 5 -> [6]
      | _ -> [] in
  let start = 3 in            (* Partenza *)
  let maxColors = 3 in        (* Massimo numero di colori*)
  let succ = Successori x in  (* Successori *)

  (Grafo (succ, start, maxColors))
;;



(*Grafo 2 *)
(* con numero di Colori insufficienti *)
let grafo_2_err = 
  let x = function        
        0 -> [1; 2; 3; 4; 5]
      | 1 -> [0; 3]
      | 2 -> [0; 5; 4]
      | 3 -> [0; 1; 4]
      | 4 -> [0; 3; 2; 5]
      | 5 -> [0; 2; 4]
      | _ -> [] in

    let start = 0 in            (* Partenza *)
    let maxColors = 3 in        (* Massimo numero di colori*)
    let succ = Successori x in  (* Successori *)
    
    (Grafo (succ, start, maxColors))
;;



(*Grafo 2 *)
(* con numero di Colori giusti *)
let grafo_2 = 
  let x = function        
        0 -> [1; 2; 3; 4; 5]
      | 1 -> [0; 3]
      | 2 -> [0; 5; 4]
      | 3 -> [0; 1; 4]
      | 4 -> [0; 3; 2; 5]
      | 5 -> [0; 2; 4]
      | _ -> [] in

    let start = 0 in            (* Partenza *)
    let maxColors = 4 in        (* Massimo numero di colori*)
    let succ = Successori x in  (* Successori *)
    
    (Grafo (succ, start, maxColors))
;;



(*Grafo 3 *)
let grafo_3 = 
  let x = function
      0 -> [1 ; 5]
    | 1 -> [0; 2]
    | 2 -> [5; 4; 3; 1; 6]
    | 3 -> [2; 6]
    | 4 -> [2]
    | 5 -> [0; 2]
    | 6 -> [2; 3]
    | _ -> [] in
    
    let start = 0 in            (* Partenza *)
    let maxColori = 3 in        (* Massimo numero di colori*)
    let succ = Successori x in  (* Successori *)

    (Grafo (succ, start, maxColori))
;;



(*Grafo 4 *)
(* definizione di un grafo con solo i successori del primo nodo*)
let grafo_4 = 
  let x = function
      0 -> [1; 2; 3; 4]
    | _ -> [] in
    
    let start = 0 in            (* Partenza *)
    let maxColori = 3 in        (* Massimo numero di colori*)
    let succ = Successori x in  (* Successori *)

    (Grafo (succ, start, maxColori))
;;







(*Lista con tutti i grafi disponibili*)
(* utilizzata per stampare i grafi disponibili*)
(* Ogni elemento è una coppia del tipo grafo, descrizione

    (un grafo è una coppia (successori, partenza, maxColori))
*)
let grafi = [
  (grafo_1,       "Grafo 1"); 
  (grafo_2,       "Grafo 2 con numero sufficiente di colori"); 
  (grafo_2_err,   "Grafo 2 con un numero di colori insufficiente per essere colorato"); 
  (grafo_3,       "Grafo 3"); 
  (grafo_4,       "Grafo 4")
];;







(*Funzione che mostra tutti i grafi dispinibili*)
(* Stampa in sequenza i grafi disponibili assegnandogli anche un ID:

    e.g.: 

    1) Grafo 1
    2) Grafo 2 ...
*)
let stampa_grafi_disponibili () = 
  let rec aux id = function (*lista di grafi*)
      []      -> print_string "\n"                    (*caso base, stampa un \n*)
    | x::coda ->                                      (*caso risocrsivo, stampa la descrizione del grafo con il suo id*)
      let stampa_elemento (_, descrizione) = 
        print_string "  "; print_int id; print_string (") " ^ descrizione ^ "\n")

      in  stampa_elemento x;                          (*continua la ricorsione, aumenta di 1 l'id e continua con la coda*)
          aux (id+1) coda     

    in aux 1 grafi  (*avvia la funzione con id=1 e lista_di_grafi=grafi*)
;;







(*Permette di scegliere un grafo tra quelli di default*)
(* Ogni grafo ha un id. Dato questo id ritorna il grafo:
    
    succ, partenza, maxColori dove

    succ:       Funzione successori
    partenza:   nodo da cui partire
    maxColori:  numero massimo di colori da utilizzare per la colorazione

  input:
    id_grafo: Id del grafo che si vuole scegliere
*)
let scegli_grafo id_grafo =
  let array_tmp = Array.of_list grafi in                  (*converte la lista in un array*)
    if id_grafo > Array.length array_tmp || id_grafo < 1  (* controlla la validità dell'id*)
      then 
        raise BadChoice                                   (* se non è valido lancia un'eccezione*)
    else
      fst (Array.get array_tmp (id_grafo-1))              (*ritorna il grafo scelto*)
;; 