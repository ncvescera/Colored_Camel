type grafo = Grafo of (int -> int list)
exception BadGraphCostruction
val bf : grafo -> int -> int list
val conta_nodi : grafo -> int -> int
val check_grafo : grafo -> bool

val x : int -> int list
val start : int
val grafo1 : grafo
val n_nodi : int
val colori : int array
val main : unit
