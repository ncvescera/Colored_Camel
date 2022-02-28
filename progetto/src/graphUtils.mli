type grafo = Grafo of (int -> int list)
exception BadGraphCostruction
exception InsufficentColorNumber;;

val colora : grafo -> int -> int -> (int * int) list
val salva_grafo_colorato: grafo -> (int * int) list -> unit
