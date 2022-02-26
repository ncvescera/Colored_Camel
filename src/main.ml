open Printer;;
open GraphUtils;;
open Data;;



(*Permette all'utente di scegliere un numero*)
(* Fin quando non viene inserito un numero valido chiede all'utente 
    di inserire un numero
*)
let scelta () = 
    let rec aux () = 
        print_string "> ";
        try 
            read_int ()
        with Failure _ -> aux ()
    in aux ()
;;


(*Funzione principale*)
let main () = 
    stampa_logo (); (*stampa il logo*)
    menu ();        (*stampa il menu*)

    let dati = 
        let rec aux () =                    (*fa scegliere all'utente un numero che rappresenta il grafo*)
            try                             (* fin quando l'utente non sceglie un numero valido continua a chiedere u numero*)
                scegli_grafo (scelta ())
            with BadChoice _ -> aux () 
        in aux() 
            in let avvia_colorazione (g, partenza, maxColori) =                             (*fa partire la funzione che colora il grafo*)
                    print_string "\n";
                    print_string "Il Grafo selezionato: \n\n"; stampa_grafo g partenza;
                    print_string "Coloro ...\n\n";

                    let colorati = colora g partenza maxColori in stampa_nodi_colorati colorati
    in avvia_colorazione dati   (*con un grafo scelto, lo colora*)
;;


main ();;