open Printer;;
open GraphUtils;;
open Data;;



print_logo ();;

(* Funzione principale *)
let main (g, start, maxColors)=
    let res = colora g start maxColors in
    print_colori res
;;

main (get_data 1);;
