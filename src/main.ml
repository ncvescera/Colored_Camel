open Printer;;
open GraphUtils;;
open Data;;

let scelta () = 
    let rec aux () = 
        print_string "> ";
        try 
            read_int ()
        with Failure _ -> aux ()
    in aux ()
;;

let main () = 
    stampa_logo ();
    menu ();

    let dati = scegli_grafo (scelta ()) in 
        let avvia_colorazione (g, partenza, maxColori) =
            print_string "\n";
            print_string "Il Grafo selezionato: \n\n"; stampa_grafo g partenza;
            print_string "Coloro ...\n\n";

            let colorati = colora g partenza maxColori in 
                stampa_nodi_colorati colorati
        in avvia_colorazione dati
;;

(* Funzione principale *)
(*
let main (g, partenza, maxColori)=
    print_string "Il Grafo selezionato: \n\n"; stampa_grafo g partenza;
    
    print_string "Coloro ...\n\n";

    let colorati = colora g partenza maxColori in
    stampa_nodi_colorati colorati
;;

main (scegli_grafo (scelta ()));;
*)
main ();;