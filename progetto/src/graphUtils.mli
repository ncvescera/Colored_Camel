type successori = Successori of (int -> int list)
type grafo = Grafo of successori * int * int
exception InsufficentColorNumber

val colora : grafo -> (int * int) list
val salva_grafo_colorato: successori -> (int * int) list -> unit
