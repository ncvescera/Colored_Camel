type colore = Colore of string;;


(*colori*)
let rosso = Colore "\027[31m";;
let verde = Colore "\027[32m";;
let ciano =  Colore "\027[36m";;
let bianco = Colore "\027[0m";;
let rosso_b = Colore "\027[31;1m";;
let verde_b = Colore "\027[32;1m";;
let ciano_b = Colore "\027[36;1m";;
let bianco_b = Colore "\027[0;1m";;

let reset = bianco;;



let stampa_logo () = 
  let aux () = print_string 
"
 ██████   ██████  █████  ███    ███ ██                                                                                   
██    ██ ██      ██   ██ ████  ████ ██                                                                                   
██    ██ ██      ███████ ██ ████ ██ ██                                                                                   
██    ██ ██      ██   ██ ██  ██  ██ ██  🐫                                                                                  
 ██████   ██████ ██   ██ ██      ██ ███████   
                                                                                                                        
     ██████  ██████   █████  ██████  ██   ██      ██████  ██████  ██       ██████  ██████  ██ ███    ██  ██████  
    ██       ██   ██ ██   ██ ██   ██ ██   ██     ██      ██    ██ ██      ██    ██ ██   ██ ██ ████   ██ ██       
    ██   ███ ██████  ███████ ██████  ███████     ██      ██    ██ ██      ██    ██ ██████  ██ ██ ██  ██ ██   ███ 
    ██    ██ ██   ██ ██   ██ ██      ██   ██     ██      ██    ██ ██      ██    ██ ██   ██ ██ ██  ██ ██ ██    ██ 
     ██████  ██   ██ ██   ██ ██      ██   ██      ██████  ██████  ███████  ██████  ██   ██ ██ ██   ████  ██████  
                                                                                                                  

     
" in aux ()
;;


(*Stampa il testo colorato*)
(* Prende un colroe e del testo. Stampa il testo col determinato colore

  input:
    colore: Colore
    testo:  Stringa da stampare
*)
let print_colore (Colore colore) testo = 
  let aux (Colore colore) testo (Colore reset) = 
    print_string (colore ^ testo ^ reset)
  in aux (Colore colore) testo reset;;






(*Stampa la lista di nodi colorati*)
(* Questa lista si ottiene dall'esecuzione delle fuanzione colora.
    Stampa tutti gli elementi della lista di colori con Nodo: x - Colore: y

    e.g.: colorati=[(0,1), (2,2), (1,0)]

      Node: 0 - Color: 1
      Node: 2 - Color: 2
      Node: 1 - Color: 0

  input:
    colorati: Lista di nodi colorati
*)
let stampa_nodi_colorati colorati = 
  let rec aux = function    (*lista di nodi colorati*)
    []              -> print_string "\n"  (*caso base, la lista è vuota*)
    | (x, y)::rest  ->                    (*caso ricorsivo, prende il primo elemento e lo stampa*)
      print_colore ciano_b "Nodo: "; print_int x;
      print_string " - "; print_colore rosso_b "Colore: "; print_int y; print_string "\n";

      aux rest;
  in aux colorati  (*avvia la ricorsione con lista_di_nodi_colorati=colorati*)
;;