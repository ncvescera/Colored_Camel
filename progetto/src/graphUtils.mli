type grafo = Grafo of (int -> int list)
type problema = Problema of grafo * int * int

exception NumeroColoriInsufficiente

val risolvi : problema -> (int * int) list
val salva_grafo_colorato: grafo -> (int * int) list -> unit