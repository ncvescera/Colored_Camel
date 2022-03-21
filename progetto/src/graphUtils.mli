type grafo = Grafo of (int -> int list)
type problema = Problema of grafo * int * int
exception InsufficentColorNumber

val colora : problema -> (int * int) list
val salva_grafo_colorato: grafo -> (int * int) list -> unit
