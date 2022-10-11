type grafo = Grafo of (int -> int list);;
type problema = Problema of grafo * int * int;;

exception NumeroColoriInsifficiente;;







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

      | _ -> (-1)       (*se la lista finisce vuol dire che il nodo non esiste.*)

  in aux nodo colorati   (*avvia la ricorsione cone nodo=nodo lista_di_nodi_colorati=colorati*)
;;







(* 
 * Incrementa di 1 il colore dei nodi vicini al nodo dato se hanno 
 * lo stesso colore. 
 *)
let incrementa_colore_nodi risultato nodi colore maxColori = 
  List.map (
      fun(x, y) -> 
                (*prende solo i        controlla che il colore            *)
                (*nodi vicini          del vicino sia uguale a quello del *)
                (*al nodo dato         nodo in esame                      *)
          if ((List.mem x nodi) && (colore=(get_colore x risultato))) 
              then 
                  let nuovo_colore = y + 1 in
                  if ((nuovo_colore) >= maxColori)        (*coltrolla che il numero massimo di colori*)
                      then                                (*non venga superato                       *)
                          raise NumeroColoriInsifficiente
                  else 
                      (x, nuovo_colore)
          else 
              (x, y)
      ) risultato
;;    







(*
 * Inizializza il risultato assegnando ad ogni nodo, raggiungibile da quello 
 * di partenza, il colore iniziale 0.   
 *)
let inizializza_risultato (Grafo succ) partenza =
  let rec bfs visitati risultato = function (* frontiera *)
      [] -> risultato                  (*esplorazione finita, ritorno il risultato*)
    | nodo::coda ->
      if List.mem nodo visitati           (*se il nodo è gia stato visitato*)
        then 
          bfs visitati risultato coda     (*lo ignoro e continuo l'esplorazione*)
      else
        bfs                               (*procedo con l'esplorazione*)
          (visitati@[nodo])                  (*aggiungo il nodo attuale alla frontiera*)
          (risultato@[(nodo, 0)])            (*assegno il colore iniziale al nodo attuale*)
          (coda@(succ nodo))                 (*aggiungo alla coda di nodi da esaminare i vicini del nodo attuale*)

      in bfs [] [] [partenza]
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







(*
 * Questa funzione ha il compito di risolvere il problema di colorazione dato.
 * Se il numero di colori è insufficiente lancia un'eccezione, altrimenti
 * colora il grafo e ritorna il risultato.
 *
 * Si basa sull'idea di confrontare il colore di un nodo dato con quello dei suoi vicini
 * e, se sono uguali, incrementa di 1 il colore del vicino.
 *
 * L'esplorazione avviene con una BFS.   
 *)
let risolvi (Problema ((Grafo succ), partenza, maxColori)) =
  let risultato = inizializza_risultato (Grafo succ) partenza in  (* inizializzo il risultato assegnando lo stesso colore a tutti i nodi *)
  let rec esplora visitati colorati = 
    function (*frontiera*)
        []            ->          (*fine delle ricorsione, se la frontiera è vuota la colorazione è finita*)
          (salva_grafo_colorato (Grafo succ) colorati; colorati)

      | nodo::coda    ->           (*caso ricorsivo, continua a colorare*)
        if List.mem nodo visitati              (*se il nodo è già stato visitato*)
          then esplora visitati colorati coda     (* ignora il nodo ed estrae il successivo dalla frontiera*)
        
        else 
          (*continua con la ricorsione espandendo i nodi vicini al nodo*)
          esplora 
                (visitati@[nodo])                                                        (*aggiunge il nodo attuale ai visitati*)
                (incrementa_colore_nodi colorati (succ nodo) (get_colore nodo colorati) maxColori) (*colora i nodi vicini a quello attuale (incrementa di 1 il loro colore)*)
                (coda@(succ nodo))                                                       (*espande i vicini del nodo attuale e li aggiunge alla frontiera*)
      
  in esplora [] risultato [partenza]
;;