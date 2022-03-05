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



(*Avvia lo script in python per la rappresentazione del grafo*)
(* Ignora il fatto che Sys.command ritorna un int*)
let avvia_python () = 
    let aux _ = () in aux (Sys.command "python rappresentazione_grafo.py grafo.data")
;;







(*Funzione principale*)
let main () = 
    stampa_logo ();                 (*stampa il logo*)
    stampa_grafi_disponibili ();    (*stampa i grafi disponibili*)

    let dati = 
        let rec aux () =                    (*fa scegliere all'utente un numero che rappresenta il grafo*)
            try                             (* fin quando l'utente non sceglie un numero valido continua a chiedere un numero*)
                scegli_grafo (scelta ())
            with BadChoice -> 
                aux () 
                in aux() 
                    in let avvia_colorazione (Grafo (g, partenza, maxColori)) =                                     (*fa partire la funzione che colora il grafo*)
                        print_string "\nIl Grafo selezionato: \n\n"; stampa_grafo (Grafo (g, partenza, maxColori)); (*  stampa il grafo nel terminale*)
                        
                        print_string "Coloro ...\n\n";
                        
                        let colorati = colora (Grafo (g, partenza, maxColori)) in       (*colora il grfo*)
                            stampa_nodi_colorati colorati;                              (* stampa il grafo colorato*)
                            salva_grafo_colorato g colorati;                            (* salva il grafo colorato per python*)
                            avvia_python ()                                             (* avvia python per mostrare a schermo il grafo*)
                        
                                in                                      (*con un grafo scelto, lo colora*)
                                    try                                 (*se il numero di colori scelto è insufficiente, stampa un errore*)
                                        avvia_colorazione dati  
                                    with InsufficentColorNumber -> 
                                        stampa_errore ()

;;


main ();;
