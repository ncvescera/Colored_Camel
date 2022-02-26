open Printer
open GraphUtils
open Data



(* Funzione principale *)
let main (g, start, maxColors)=
    let res = colora g start maxColors in
    print_colori res
;;

main (get_data 1);;