let print_logo () = 
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


(*Stampa la lista di nodi colorati*)
(* Questa lista si ottiene dall'esecuzione delle fuanzione colora.
    Stampa tutti gli elementi della lista di colori con Nodo: x - Colore: y

    e.g.: colored_graph=[(0,1), (2,2), (1,0)]

      Node: 0 - Color: 1
      Node: 2 - Color: 2
      Node: 1 - Color: 0

  input:
    colored_graph: Lista di nodi colorati
*)
let print_colori colored_graph = 
  let rec aux = function    (*lista di nodi colorati*)
    []              -> print_string "\n"  (*caso base, la lista è vuota*)
    | (x, y)::rest  ->                    (*caso ricorsivo, prende il primo elemento e lo stampa*)
      print_string "Node: "; print_int x;
      print_string " - Color: "; print_int y; print_string "\n";

      aux rest;
  in aux colored_graph  (*avvia la ricorsione con lista_di_nodi_colorati=colored_graph*)
;;