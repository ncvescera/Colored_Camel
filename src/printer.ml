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

      Nodo: 0 - Colore: 1
      Nodo: 2 - Colore: 2
      Nodo: 1 - Colore: 0

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







(*Stampa una data lista*)
(* Stampa ogni lemento della lista separato da uno spazio. Alla fine un ritorno a capo

    e.g.: lista=[0;2;3;4] --> 0 2 3 4

  input:
    lista: Lista da stampare
*)
let rec stampa_lista = function (* lista *)
    []      -> print_string "\n"    (*caso base, la lista è finita. Stampa ritorno a capo*)
  | x::coda ->                      (*caso ricorsivo, stampa l'elemento e continua*)
      print_int x; 
      print_string " ";
      stampa_lista coda
;;

(*Stampa un grafo dato*)
(* Dato un grafo e il nodo di partenza stampa il grafo
    
    e.g.: grafo 3
      3 ➜ 0 1
      0 ➜ 3 2
      ...

  input:
    g:        Grafo da stampare
    partenza: Nodo di partenza
*)
let stampa_grafo (GraphUtils.Grafo g) partenza =
  let rec search visitati = function  (* frontiera *)
      [] -> print_string "\n"         (*caso base, la lista è vuota. Stampa un ritorno a capo*)      
      | nodo::coda ->                 (*caso ricorsivo, stampa il nodo ed i suoi vicini. Poi continua*)
          if List.mem nodo visitati     (* il nodo è già stato visto, lo ignora*)
            then search visitati coda
          else                          (* stampa il nodo ed i suoi vicini. Poi continua*)
            (
              print_int nodo; print_string " ➜ "; stampa_lista (g nodo); 
              search (visitati@[nodo]) (coda@(g nodo))
            )

  in search [] [partenza];; (*avvia la ricorsione con visitati=[] e frontiera=[partenza]*)