type grafo = Grafo of (int -> int list);;
exception BadGraphCostruction;; (*??*)
exception InsufficentColorNumber;;


(* ------------------------------------------ *)







(*Trova il colore di un nodo*)
(* Va a cercare il nodo tra la lista dei nodi colorati, se esiste ritorna il suo colore
    altrimenti -1
    
    e.g.: node=1 colored=[(0,10), (5,1), (7,9)]

      (0, 10) -> 0 = 1 ? NO
      (5, 1)  -> 5 = 1 ? NO
      (7, 9)  -> 7 = 1 ? NO
      
      lista finita -> -1 (il nodo non è stato colorato)

    e.g.: node=1 colored=[(1,10), (5,1), (7,9)]

      (1, 10) -> 1 = 1 ? SI -> 10

  input:
    node:    Nodo di cui si vuole ottenere il colore
    colored: Lista di nodi colorati
*)
let get_node_color node colored = 
  let rec aux node = function (*lista di nodi colorati*)
      (x,y)::tail ->  (*caso ricorsivo, prende il primo elemento della forma (x,y)*)
        if x = node     (*se l'elemento in questione è il nodo che cerco*)
          then y        (* ritorna il colore del nodo*)
        else 
          aux node tail (*continua con la ricorsione*)
      | _ -> (-1)       (*se la lista finisce vuol dire che il nodo non è colorato.*)

  in aux node colored   (*avvia la ricorsione cone node=node lista_di_nodi_colorati=colored*)
;;







(*Trova il massimo tra tutti gli elementi di una lista data*)
(* Trova il massimo tra ogni elemento e il massimo degli elementi successivi (ricorsivamente)

    e.g.: [0, 9, 1]

      max 0 [max 9 [max 1]]
      max 0 [max 9 1]
      max 0 9
      9

  input:
      list: Lista su cui trovare il massimo
*)
let rec list_max = function   (* lista su cui trovare il massimo *)
    [x]       -> x                      (*caso base, la lista ha un solo elemento. Ritrona lui come massimo*)
    | x::tail -> max x (list_max tail)  (*caso ricorsivo, prende il primo elemento e trova il massimo tra lui e gli altri.*)
    | _       -> 0                      (*in tutti gli altri casi [per essere sicuro]*)
;;







(*Trova tutti i colori vicini di un nodo*)
(* Per ogni nodo ne perende il colore e lo aggiunge al risultato

    e.g.: nodo=4, adj=[1,3,5] colored=[(1,0),(3,-1),(5,4), (20, 0),(11,-1)]
      
      result = [0, -1, 4]

  input:
      lista:  Lista di nodi adiacenti al nodo in questione
      colored: Lista di nodi colorati
*)
let rec all_adj_colors lista colored=
  let rec aux result = function (*lista di nodi*)
    []        -> result   (*caso base, non ci sono più nodi di cui prendere il colore. Ritorna tutti i colori trovati*)
    | x::tail ->          (*caso ricorsivo, esamina il primo nodo*)
      aux 
          (result@[get_node_color x colored]) (*aggiunge al risultato il colore del nodo analizzato*)
          tail                                (*toglie il nodo analizzato dalla lista e continua*)
  
  in aux [] lista   (*avvia la ricorsione con result=[] e lista_di_nodi=lista*)
;;


(*Trova il massimo tra i colori vicini di un nodo*)
(* Prende i colori vicini del nodo [all_adj_colors()] e 
   trova il massimo di questa lista [list_max()]
   
  input:
      g:      Grafo
      node:   Nodo da analizzare
      colore: Lista di nodi colorati

*)
let max_node_adj_color (Grafo g) node colored =
  let adj = (g node) in                         (*prende i vicini del nodo*)            
    let colori = all_adj_colors adj colored     (*prende tutti i colori dei vicini*)
  in list_max colori                            (*calcola il massimo tra tutti i colori presi*)
;;






(*valore di rifermineto per trovare il nodo mancante*)
(* il valore qui è solo un placeholder, viene cambianto appena avviata la funzione colora!!*)
let refValue = ref 10;; 







(*Trova il colore mancate tra i colori vicini al nodo [se esiste]*)
(* Per trovare il colore mancate, 
   somma tutti i colori dei vicini [adj_colors] e sottrae questo numero al valore di riferimento
   
   e.g.: 
    maxColor=4 --> ref_value = 3+2+1+0 = 6 (calcolato all'inizio) adj_colors=[0,2,3]
      somma = 0 + 2 + 3 = 5
      risultato = ref_value - somma = 1

  input: 
    adj_colors: Lista dei colori adiacenti al nodo
    maxColor:   Numero massimo di colori da utilizzare
*)
let find_missing adj_colors maxColor = 
  let rec sum result = function (*lista di elementi da sommare*)
    []        -> result   (*caso base, non ci sono più elementi da sommare. Ritorna il risultato [la somma]*)
    | x::tail ->          (*caso ricorsivo, prende il primo elemento nella lista*)
      if x = (-1)                   (*se è -1: nod non colorato*)
        then sum (result + 0) tail  (* somma 0 (lo ignora) e va avanti*)
      else sum (result + x) tail    (*altrimenti somma il colore e va avanti*)
  in let somma = sum 0 adj_colors in  (*trova la somma di tutti i colori adiacenti al nodo*)
    if somma > !refValue                      (*somma superiore al valore di rifierimento, c'è un problema [controllo per sicurezza]*)
      then raise InsufficentColorNumber
    else if somma < (maxColor -1)             (*somma eccessivamente bassa, mancano più elementi. Tenta di trovarne uno [controllo per sicurezza]*)
      then (!refValue - somma) mod !refValue
    else (!refValue - somma)                  (*ritorna il colore mancante*)
;;







(*Trova il valore di riferimento*)
(* Serve per calcolare il colore mancate: è la somma di tutti i valori dei colori.
    e.g.: se maxColor = 4 allora ref_value = 0 + 1 + 2 + 3 = 6

      3 + (3-1) + (3-1-1) + ... + 0

  input:
    maxColor: Massimo numero di colori
*)
let find_refValue maxColor = 
  let rec aux result = function (* colore *)
    0 -> result                     (*caso base, è alla fine perchè l'ultimo colore che analizza è 0. Ritorna il risultato*)
    | x -> aux (result+(x-1)) (x-1) (*caso ricorsivo, somma al risultato il colore precedente all'attuale*)
  in aux 0 maxColor                 (*avvia la ricorsione con result=0 e colore=maxColor*)
;;               







(*Sceglie il colore per il nodo dato*)
(* Il colore per il nodo è: (massimo dei colori vicini + 1) mod maxColor
   Se il colore scelto è uguale ad un colore dei vicini del nodo, 
    prova a capire se può sceglierne un altro (cerca quello che manca). Se è impossibile lancia un'eccezione, altrimenti ritorna il mancante.
   Altrimenti ritorna il colore scelto.

  input:
    g:        Grafo (per trovare i vicini del nodo)
    node:     Nodo in questione
    colored:  Lista di nodi colorati
    maxColor: Massimo numero di colori
*)
let choose_color (Grafo g) node colored maxColor = 
  let result = ((max_node_adj_color (Grafo g) node colored) + 1) in (*trova il massimo tra i colori dei vicini del nodo*)
    let adj_colors = all_adj_colors (g node) colored in             (*tutti i colri vicini*)
      let result_mod = result mod maxColor in                       (*calcola il modulo così da avere il risultato pronto*)
        if List.mem result_mod adj_colors                           (*il colore scelto è lo stesso di un colore vicino*)
          then let missing = find_missing adj_colors maxColor in    (* prova a capire se può scegliere un altro colore [trova il mancante tra i vicini]*)
            if List.mem missing adj_colors 
              then raise InsufficentColorNumber                     (*  è impossibile, numero di colori insufficiente !!*)
            else missing                                            (*  è possibile, ritorna il colore mancante*)
        
        else result_mod                                            (*trovato un colore valido, lo ritorna*)
;;






(* Colora in grafo in modo da non avere nodi adiacenti con lo stesso colore*)
(* input:
    g:        Grafo
    start:    Nodo di partenza
    maxcolor: Massimo numero di colori da utilizzare
*)
let colora (Grafo g) start maxcolor =
  refValue := find_refValue maxcolor;       (*valore per trovare il colore mancante*)
  let rec search visited colored = 
    function (*frontiera*)
      []            -> colored  (*fine delle ricorsione, se la frontiera è vuota colorazione finita*)
      | node::tail  ->          (*caso ricorsivo, continua a colorare*)
        if List.mem node visited 
          then search visited colored tail  (*ignora il nodo ed estrae il successivo dalla frontiera*)
        else 
          (*continua con la ricorsione espandendo i nodi vicini al nodo*)
          search 
                (visited@[node])  (*aggiunge il nodo attuale ai visitati*)
                (colored@[(node, (choose_color (Grafo g) node colored maxcolor))])  (*colora il nodo [aggiunge la coppia (nodo,colore) a colored]*)
                (tail@(g node))   (*espande i vicini del nodo attuale e li aggiunge alla frontiera*)
      
  in search [] [] [start]   (*avvia la ricerca e la colorazione, visited=[], colored=[], frontiera=[start]*)
;;