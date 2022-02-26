open Printer;;
open GraphUtils;;
open Data;;



stampa_logo ();;

(* Funzione principale *)
let main (g, partenza, maxColori)=
    let colorati = colora g partenza maxColori in
    stampa_nodi_colorati colorati
;;

main (scegli_grafo 1);;
