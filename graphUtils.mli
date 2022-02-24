type grafo = Grafo of (int -> int list)
exception BadGraphCostruction

val bf : grafo -> int -> int list
val conta_nodi : grafo -> int -> int
