type grafo = Grafo of (int -> int list);;
type problema = Problema of grafo * int * int;;
exception InsufficentColorNumber;;







(*Trova il colore di un nodo*)
(* Va a cercare il nodo tra la lista dei nodi colorati, se esiste ritorna il suo colore
    altrimenti -1
    
    e.g.: nodo=1 colorati=[(0,10), (5,1), (7,9)]

      (0, 10) -> 0 = 1 ? NO
      (5, 1)  -> 5 = 1 ? NO
      (7, 9)  -> 7 = 1 ? NO
      
      lista finita -> -1 (il nodo non è stato colorato)

    e.g.: nodo=1 colorati=[(1,10), (5,1), (7,9)]

      (1, 10) -> 1 = 1 ? SI -> 10

  input:
    nodo:     Nodo di cui si vuole ottenere il colore
    colorati: Lista di nodi colorati
*)
let get_colore nodo colorati = 
  let rec aux nodo = function (*lista di nodi colorati*)
      (x,y)::coda ->    (*caso ricorsivo, prende il primo elemento della forma (x,y)*)
        if x = nodo     (*  se l'elemento in questione è il nodo che cerco*)
          then y        (*    ritorna il colore del nodo*)
        else 
          aux nodo coda (*  continua con la ricorsione*)

      | _ -> (-1)       (*se la lista finisce vuol dire che il nodo non è colorato.*)

  in aux nodo colorati   (*avvia la ricorsione cone nodo=nodo lista_di_nodi_colorati=colorati*)
;;







(*Trova il massimo tra tutti gli elementi di una lista data*)
(* Trova il massimo tra ogni elemento e il massimo degli elementi successivi (ricorsivamente)

    e.g.: [0, 9, 1]

      max 0 [max 9 [max 1]]
      max 0 [max 9 1]
      max 0 9
      9

  input:
      lista: Lista su cui trovare il massimo
*)
let rec max_lista = function   (* lista su cui trovare il massimo *)
     [x]      -> x                      (*caso base, la lista ha un solo elemento. Ritrona lui come massimo*)
    | x::coda -> max x (max_lista coda) (*caso ricorsivo, prende il primo elemento e trova il massimo tra lui e gli altri.*)
    | _       -> 0                      (*in tutti gli altri casi [per essere sicuro]*)
;;







(*Trova tutti i colori vicini di un nodo*)
(* Per ogni nodo ne perende il colore e lo aggiunge al risultato

    e.g.: nodo=4, vicini=[1,3,5] colorati=[(1,0),(3,-1),(5,4), (20, 0),(11,-1)]
      
      risultato = [0, -1, 4]

  input:
      vicini:   Lista di nodi adiacenti al nodo in questione
      colorati: Lista di nodi colorati
*)
let rec tutti_colori_vicini vicini colorati =
  let rec aux risultato = function (*lista di nodi*)
      []        -> risultato   (*caso base, non ci sono più nodi di cui prendere il colore. Ritorna tutti i colori trovati*)
    | x::coda   ->             (*caso ricorsivo, esamina il primo nodo*)
      aux 
          (risultato@[get_colore x colorati]) (*aggiunge al risultato il colore del nodo analizzato*)
          coda                                (*toglie il nodo analizzato dalla lista e continua*)
  
  in aux [] vicini   (*avvia la ricorsione con risultato=[] e lista_di_nodi=vicini*)
;;



(*Trova il colore massimo (il colore con valore più alto) tra i colori vicini di un nodo*)
(* Prende i colori vicini del nodo [tutti_colori_vicini()] e 
   trova il massimo di questa lista [max_lista()]
   
  input:
      succ:     Funzione successori
      nodo:     Nodo da analizzare
      colorati: Lista di nodi colorati
*)
let max_colore_vicini (Grafo succ) nodo colorati =
  let vicini = (succ nodo) in                                     (*prende i vicini del nodo*)            
    let colori_vicini = tutti_colori_vicini vicini colorati in    (*  prende tutti i colori dei vicini*)
      max_lista colori_vicini                            (*calcola il massimo tra tutti i colori presi*)
;;





           

(*Calcola la lista con tutti i colori disponibili*)
(*  Funzione che dato il massimo numero di colori restituisce
    una lista con tutti i colori.

    e.g.: 
      maxColori = 3 risultato = [0; 1; 2]

  input:
    maxColori: numero di colori da utilizzare
*)
let calcola_lista_colori maxColori = 
  let rec aux risultato = function (* colore *)
      0 -> List.rev risultato               (*caso base, tutti i colori analizzati. Ritorna la lista invertita [con il giusto ordine]*)
    | x -> 
      aux                                   (*caso ricorsivo, somma al risultato il colore precedente all'attuale per trovare un nuovo colore*)
        (risultato@[(x-1)])                 (* aggiunge il numero alla lista*)
        (x-1)                               (* continua con il nuovo numero*)
  in aux [] maxColori     (*avvia la funzione con risultato=[] e colore=maxColori*)
;;







(*Lista con tutti i colori disponibili*)
(*  Verrà poi utilizzata per cercare di trovare un possibile colore per i nodi.
    Verrà successivamente inizializzata con tutti i colori disponibili
*)
let lista_colori = ref [0;];;



(*Funzione per trovare un possibile colore per un nodo dato*)
(*  La funzione controlla tutti i colori vicini del nodo e ricorsivamente
    va a controllare se un colore è sato già assegnato.

    - Se il colore in esame è stato assegnato (un nodo adiacente ha quel colore) passa al successivo
    - Se un colore non è stato assegnato viene ritornato

    Se tutti i colori disponibili sono stati assegnati, solleva un'eccezione.

  input:
    succ:     Funzione successori (il grafo)
    nodo:     Nodo da colorare
    colorati: Lista con tutti i nodi colorati
*)
let scegli_colore (Grafo succ) nodo colorati = 
  let vicini = succ nodo in                                         (*tutti i vicini del nodo*)
    let colori_vicini = tutti_colori_vicini vicini colorati in      (*tutti i colori vicini del nodo*)
      let rec cerca_colore_nonusato = function (* lista colori da provare*)
        []        -> raise InsufficentColorNumber;    (*caso base, non ci sono colori disponibili*)
        |x::coda  ->                                  (*caso ricorsivo, analizza il colore*)
          if List.mem x colori_vicini                 (* il colore è tra i colori vicini*)
            then
              cerca_colore_nonusato coda              (*  continua la ricorsione ignorandolo*)
        else                                          (* il colore non è tra i vicini*)
          x                                           (*  trovato! Lo ritorna*)
        in cerca_colore_nonusato !lista_colori      (*avvia la ricorsione con la lista di colori*)
;;



let colora (Problema ((Grafo succ), partenza, maxColori)) =
  lista_colori := calcola_lista_colori maxColori;          (*valore per trovare il colore mancante*)
  let rec esplora visitati colorati = 
    function (*frontiera*)
        []            -> colorati  (*fine delle ricorsione, se la frontiera è vuota la colorazione è finita*)
      | nodo::coda    ->           (*caso ricorsivo, continua a colorare*)
        if List.mem nodo visitati              (*se il nodo è già stato visitato*)
          then esplora visitati colorati coda  (* ignora il nodo ed estrae il successivo dalla frontiera*)
        
        else 
          (*continua con la ricorsione espandendo i nodi vicini al nodo*)
          esplora 
                (visitati@[nodo])                                                              (*aggiunge il nodo attuale ai visitati*)
                (colorati@[(nodo, (scegli_colore (Grafo succ) nodo colorati))]) (*colora il nodo [aggiunge la coppia (nodo,colore) a colorati]*)
                (coda@(succ nodo))                                                             (*espande i vicini del nodo attuale e li aggiunge alla frontiera*)
      
  in esplora [] [] [partenza]   (*avvia la ricerca e la colorazione, visitati=[], colorati=[], frontiera=[partenza]*)
;;







(*Funzione per salvare un grafo colorato su file*)
(* Dato un grafo e i suoi nodi colorati, salva su file il grafo nella forma:
    nodo,vicini,colore nodo
  
    e.g.: il nodo 1 confina con i nodi 2, 0, 5, 6 ed ha il colore 0
      1, 2 0 5 6,0

  input:
    succ:     Funzione successori
    colorati: Lista di coppie nodo - colore
*)
let grafodati_file = "grafo.data";; (*Nome del file su cui vengono salvati i dati del grafo*)
let salva_grafo_colorato (Grafo succ) colorati = 
  let oc = open_out grafodati_file in           (*Apertura del file in scrittura*)
    let rec salva_lista =                       (*Funzione ausiliaria per salvare su file una lista data*)
      function (* lista *)
         [x]      -> Printf.fprintf oc "%d" x   (* caso base, se la lista ha un solo elemento lo stampa (senza " ")*)
        | x::coda ->                            (* caso ricorsivo, la lista ha più elementi*)            
          Printf.fprintf oc "%d " x;            (*  stampa l'elemento*)
          salva_lista coda                      (*  continua la ricorsione*)
        | _ -> ()
    in let rec salva =                                (*Funzione ausiliaria per salvare nodo - vicini - colore su file*)
      function (* lista nodi_colorati *)
         [] -> Printf.fprintf oc "\n"; close_out oc   (* caso base, la lista è finita. Stampo un \n e chiudo il file*)
        |(nodo, colore)::coda ->                      (* caso ricorsivo, stampo nodo,lista vicini,colore nodo*)
          Printf.fprintf oc "%d," nodo; salva_lista (succ nodo); Printf.fprintf oc ","; Printf.fprintf oc "%d\n" colore; 
          salva coda

    in salva colorati (*avvia la funzione ausiliaria per salvare il grafo su file*)
;;







(*VECCHIE FUNZIONI*)
(* Per ora le tengo solo per sicurezza, poi andranno eliminate !!*)
(* TODO: rimuoverle quando inutili*)

(*


(*Valore di rifermineto per trovare il nodo mancante*)
(* il valore qui è solo un placeholder, viene cambianto appena avviata la funzione colora!!*)
let refValue = ref 10;; 




(*Trova il colore mancate tra i colori vicini al nodo [se esiste]*)
(* Per trovare il colore mancate, 
   somma tutti i colori dei vicini [colori_vicini] e sottrae questo numero al valore di riferimento
   
   e.g.: 
    maxColori=4 --> ref_value = 3+2+1+0 = 6 (calcolato all'inizio) colori_vicini=[0,2,3]
      somma = 0 + 2 + 3 = 5
      risultato = ref_value - somma = 6 - 5 = 1

  input: 
    colori_vicini: Lista dei colori adiacenti al nodo
    maxColori:     Numero massimo di colori da utilizzare
*)
let trova_mancante colori_vicini maxColori = 
  let rec sum risultato = function (*lista di elementi da sommare*)
      []        -> risultato          (*caso base, non ci sono più elementi da sommare. Ritorna il risultato [la somma]*)
    | x::coda   ->                    (*caso ricorsivo, prende il primo elemento nella lista*)
        if x = (-1)                         (*se è -1: nodo non colorato*)
          then sum (risultato + 0) coda     (* somma 0 (lo ignora) e va avanti*)
        else sum (risultato + x) coda       (*altrimenti somma il colore e va avanti*)
  
  in let somma = sum 0 colori_vicini in  (*trova la somma di tutti i colori adiacenti al nodo*)
    if somma > !refValue                       (*somma superiore al valore di rifierimento, c'è un problema [controllo per sicurezza]*)
      then raise InsufficentColorNumber

    else if somma < (maxColori -1)             (*somma eccessivamente bassa, mancano più elementi. Tenta di trovarne uno [controllo per sicurezza]*)
      then (!refValue - somma) mod !refValue

    else (!refValue - somma)                   (*ritorna il colore mancante*)
;;





(*Trova il valore di riferimento*)
(* Serve per calcolare il colore mancate: è la somma di tutti i valori dei colori.
    e.g.: se maxColori = 4 allora ref_value = 0 + 1 + 2 + 3 = 6

      3 + (3-1) + (3-1-1) + ... + 0

  input:
    maxColori: Massimo numero di colori
*)
let calcola_refValue maxColori = 
  let rec aux risultato = function (* colore *)
      0 -> risultato                     (*caso base, è alla fine perchè l'ultimo colore che analizza è 0. Ritorna il risultato*)
    | x -> aux (risultato+(x-1)) (x-1)   (*caso ricorsivo, somma al risultato il colore precedente all'attuale*)
  in aux 0 maxColori                   (*avvia la ricorsione con risultato=0 e colore=maxColori*)
;; 





(*Sceglie il colore per il nodo dato*)
(* Il colore per il nodo è: (massimo dei colori vicini + 1) mod maxColori
   Se il colore scelto è uguale ad un colore dei vicini del nodo, 
    prova a capire se può sceglierne un altro (cerca quello che manca). Se è impossibile lancia un'eccezione, altrimenti ritorna il mancante.
   Altrimenti ritorna il colore scelto.

  input:
    succ:      Funzione successori (per trovare i vicini del nodo)
    nodo:      Nodo in questione
    colorati:  Lista di nodi colorati
    maxColori: Massimo numero di colori
*)
let scegli_colore_old (Grafo succ) nodo colorati maxColori = 
  let risultato = ((max_colore_vicini (Grafo succ) nodo colorati) + 1) in (*trova il massimo tra i colori dei vicini del nodo*)
    let colori_vicini = tutti_colori_vicini (succ nodo) colorati in            (*trova tutti i colri vicini*)
      let risultato_mod = risultato mod maxColori in                        (*calcola il modulo così da avere il risultato pronto*)
        if List.mem risultato_mod colori_vicini                             (*il colore scelto è lo stesso di un colore vicino*)
          then let mancante = trova_mancante colori_vicini maxColori in     (* prova a capire se può scegliere un altro colore [trova il mancante tra i vicini]*)
            if List.mem mancante colori_vicini 
              then raise InsufficentColorNumber                             (*  è impossibile, numero di colori insufficiente !!*)
            
            else mancante                                                   (*  è possibile, ritorna il colore mancante*)
        
        else risultato_mod                                          (*trovato un colore valido, lo ritorna*)
;;





(* 
let p (Grafo succ) (nodo, colore) colorati = 
  let vicini = succ nodo in
  let colori_vicini = tutti_colori_vicini vicini colorati in
    let rec aux = function (*colori vicini*)
      [] -> true
      | x::coda -> 
        if x = colore
          then false
      else
        aux coda
      in aux colori_vicini
      ;;

let colora (Problema ((Grafo succ), partenza, maxColori)) =
  lista_colori := calcola_lista_colori maxColori;       (*valore per trovare il colore mancante*)
 (* from_node cerca un cammino a partire dal nodo a *)
 let rec from_node visited colorati a =
  print_int a;
  let c = scegli_colore (Grafo succ) a colorati in
  if List.mem (a,c) colorati (*?? non ha molto senso*)
     then raise InsufficentColorNumber
else if List.length colorati = 5 then colorati
(*   else if p (Grafo succ) (a,c) colorati then (colorati@[(a,c)])(* [(a,c)] *)  (* il cammino e’ trovato *) *)
  else (a,c)::from_list (colorati@[(a,c)]) (visited@[a]) (succ a) (*dovrei aggiungere elementi a colorati ??*)
  (* cerca un cammino da uno dei successori di a *)

(* from_list cerca un cammino che parta da uno dei nodi della lista suo argomento *)
and from_list colorati visited = function (*frontiera*)
  [] -> raise InsufficentColorNumber
  | a::rest -> try from_node visited colorati a
      with InsufficentColorNumber -> from_list colorati visited rest

  in from_node [] [] partenza;; 














let colora_test (Problema ((Grafo succ), partenza, maxColori)) =
  lista_colori := calcola_lista_colori maxColori;       (*valore per trovare il colore mancante*)
  let rec esplora visitati colorati = 
    function (*frontiera*)
        []            -> colorati  (*fine delle ricorsione, se la frontiera è vuota la colorazione è finita*)
      | nodo::coda    ->           (*caso ricorsivo, continua a colorare*)
        if List.mem nodo visitati              (*se il nodo è già stato visitato*)
          then esplora visitati colorati coda  (* ignora il nodo ed estrae il successivo dalla frontiera*)
        
        else 
          (*continua con la ricorsione espandendo i nodi vicini al nodo*)
          esplora 
                (visitati@[nodo])                                                              (*aggiunge il nodo attuale ai visitati*)
                (colorati@[(nodo, (scegli_colore (Grafo succ) nodo colorati))]) (*colora il nodo [aggiunge la coppia (nodo,colore) a colorati]*)
                (coda@(succ nodo))                                                             (*espande i vicini del nodo attuale e li aggiunge alla frontiera*)
      
  in esplora [] [] [partenza]   (*avvia la ricerca e la colorazione, visitati=[], colorati=[], frontiera=[partenza]*)
;; *)





(* Colora in grafo in modo da non avere nodi adiacenti con lo stesso colore*)
(* input:
    succ:      Funzione successori
    partenza:  Nodo di partenza
    maxColori: Massimo numero di colori da utilizzare
*)
let colora_old (Problema ((Grafo succ), partenza, maxColori)) =
  refValue := calcola_refValue maxColori;       (*valore per trovare il colore mancante*)
  let rec esplora visitati colorati = 
    function (*frontiera*)
        []            -> colorati  (*fine delle ricorsione, se la frontiera è vuota la colorazione è finita*)
      | nodo::coda    ->           (*caso ricorsivo, continua a colorare*)
        if List.mem nodo visitati              (*se il nodo è già stato visitato*)
          then esplora visitati colorati coda  (* ignora il nodo ed estrae il successivo dalla frontiera*)
        
        else 
          (*continua con la ricorsione espandendo i nodi vicini al nodo*)
          esplora 
                (visitati@[nodo])                                                              (*aggiunge il nodo attuale ai visitati*)
                (colorati@[(nodo, (scegli_colore_old (Grafo succ) nodo colorati maxColori))]) (*colora il nodo [aggiunge la coppia (nodo,colore) a colorati]*)
                (coda@(succ nodo))                                                             (*espande i vicini del nodo attuale e li aggiunge alla frontiera*)
      
  in esplora [] [] [partenza]   (*avvia la ricerca e la colorazione, visitati=[], colorati=[], frontiera=[partenza]*)
;;





*)