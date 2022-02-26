open Printer;;
open GraphUtils;;
open Data;;



stampa_logo ();;

(* Funzione principale *)
let main (g, partenza, maxColori)=
    print_string "Il Grafo selezionato: \n\n"; stampa_grafo g partenza;
    
    print_string "Coloro ...\n\n";

    let colorati = colora g partenza maxColori in
    stampa_nodi_colorati colorati
;;

main (scegli_grafo 1);;
