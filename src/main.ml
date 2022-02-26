open Printer;;
open GraphUtils;;
open Data;;



stampa_logo ();;

(* Funzione principale *)
let main (g, start, maxColors)=
    let colorati = colora g start maxColors in
    stampa_nodi_colorati colorati
;;

main (get_data 1);;
