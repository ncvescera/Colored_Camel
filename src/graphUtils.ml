(* Strutture dati ed eccezioni *)
type grafo = Grafo of (int -> int list);;
exception BadGraphCostruction;;
exception InsufficentColorNumber;;

(* ------------------------------------------ *)


(* ritorna una lista con tutti i nodi esplorati*)
let bf (Grafo succ) start =
    let rec search visited = function
        [] -> visited
        | node::tail -> if List.mem node visited 
                            then search visited tail
                        else search (visited@[node]) (tail@(succ node))
    in search [] [start];;



let print_colorazione node colore = 
  print_string "nodo: "; print_int node; print_string " ";
  print_string "col: "; print_int colore; print_string "\n"
;;

let colorati = ref [];;

let rec is_node_colored nodo = function
  [] -> false
  | (x,y)::tail -> if x = nodo then true
  else is_node_colored nodo tail;;

  let rec get_node_color nodo = function
    (x,y)::tail -> 
      if x = nodo then y
      else get_node_color nodo tail
    | _ -> (-1);;


(* trova il massimo degli elementi di una data lista *)
let rec list_max = function             (* lista su cui trovare il massimo *)
    [x] -> x
    | x::tail -> max x (list_max tail)
    | _ -> 0;;

(* dati i vicini di un nodo e i nodi colorati, ritorna tutti i colori dei vicini *)
(* ritorna tutti i colori dei vicini di un nodo *)
let rec all_ajc_colors lista colored=
  let rec aux result = function 
    [] -> result
    | x::tail -> aux (result@[get_node_color x colored]) tail in aux [] lista;;

(* dal grafo, un nodo e i nodi colorati ritorna il colore max dei vicini del nodo *)
(* calcola il massimo colore tra i vicini del nodo node *)
let max_node_adj_color (Grafo g) node colored =
  let adj = (g node) in                         (* prende i vicini del nodo node**)            
    let colori = all_ajc_colors adj colored     (* prende tutti i colori dei vicini *)
  in list_max colori;;                          (* calcola il massimo tra tutti i colori presi *)


let refValue = ref 10;;

(* trova il colore mancate tra i colori vicini al nodo se esiste*)
let find_missing adj_colors maxColor = 
  let rec sum result = function (*lista di elementi da sommare*)
    [] -> result
    | x::tail -> if x = (-1) then sum (result + 0) tail
    else sum (result + x) tail
  in let somma = sum 0 adj_colors in 
    print_string "in find_missing "; print_int somma; print_string "\n";
    if somma > !refValue then raise InsufficentColorNumber
    else if somma < (maxColor -1) then (!refValue - somma) mod !refValue
    else (!refValue - somma);;


let find_refValue maxColor = 
let rec aux result = function (* colore *)
  0 -> result
  | x -> aux (result+(x-1)) (x-1)
in aux 0 maxColor;;

(* dal grafo e dalla lista dei nodi colorati, ritorna il colore per il nuovo nodo*)
(* controlla i vicini e ritorna il max color + 1 *)
let choose_color (Grafo g) node colored maxColor = 
  (*
  let colori_vicini = all_ajc_colors (g node) colored in
  let colore_mancante = find_missing colori_vicini maxColor in
  colore_mancante;;*)
  
    let result = ((max_node_adj_color (Grafo g) node colored) + 1) in 
      let adj_colors = all_ajc_colors (g node) colored in
        let result_mod = result mod maxColor in
          if List.mem result_mod adj_colors then (*raise InsufficentColorNumber*)
            let missing = find_missing adj_colors maxColor in
              if List.mem missing adj_colors then raise InsufficentColorNumber
              else missing
          else result_mod;;
          







let colora (Grafo g) start maxcolor =
  refValue := find_refValue maxcolor; 
  print_string "ref: "; print_int !refValue; print_string "\n";
  let rec search visited colored = function (*frontiera*)
    [] -> colored
    | node::tail ->
      if List.mem node visited then search visited colored tail
      else 
        search (visited@[node]) (colored@[(node, (choose_color (Grafo g) node colored maxcolor))]) (tail@(g node)) 
      in search [] [] [start];;
  
  
      (*
    let rec search visited _color = function
      [] -> exit 0
      | node::tail -> if List.mem node visited 
                          then search visited _color tail

                      else if _color > maxcolor 
                        then 
                          (print_colorazione node 0;search (visited@[node]) 1 (tail@(g node)) )
                      else  
                            print_colorazione node _color;
                            search (visited@[node]) (_color + 1) (tail@(g node)) 
    in search [] 0 [start];;
    *)


(* ------------------------------------------ *)

(* Conta il numero di nodi raggiungibili dallo start del grafo *)
let conta_nodi (Grafo g) start = List.length (bf (Grafo g) start);;

(* il grafo deve partire da 0 [forse inutile]*)
let check_grafo (Grafo g) = 
    if g 0 = [] 
        then raise BadGraphCostruction
    else true;;

(* ------------------------------------------ *)