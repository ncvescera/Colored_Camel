type grafo = Grafo of (int -> int list)
exception BadGraphCostruction
exception InsufficentColorNumber;;

val colora : grafo -> int -> int -> (int * int) list
val conta_nodi : grafo -> int -> int

