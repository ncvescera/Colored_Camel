import random
from pyvis.network import Network
from sys import argv


def main(fname):
    """
        Questo script rappresenta un grafo con pyvis.
        Prende in input il file (che rappresenta un grafo) generato dal programma OCaml e rappresenta il relativo grafo con i colori.
    """

    collegamenti = []
    nodi = []
    colori = []

    # lettura dei dati da file
    with open(fname, 'r') as f:
        for text in f.readlines():
            text = text.strip("\n")                             # elimina i vari \n nel file
            if text != '':                                      # controlla che la riga sia valida
                nodo, vicini, colore  = text.split(",")         # prende nodo, vicini e colore
                
                vicini = vicini.split(" ")                      # dalla stringa prende tutti i singoli vicini
                colori.append(int(colore))                      # aggiunge il colore alla lista dei colori (converte in int)
                
                if vicini[0] != '':                             # controlla se il nodo ha vicini
                    for vicino in vicini:                           # crea la lista di vicini (crea gli archi del grafo)
                        tmp = (int(nodo), int(vicino))
                        collegamenti.append(tmp)    
    
    nodi = trova_nodi(collegamenti)                             # controlla che abbia trovato tutti i nodi dalla sola analisi del file
    colori = aggiusta_colori(colori)                            # converte i colori da int a stringa hex per pyvis

    # print(nodi)
    # print(collegamenti)
    # print(colori)

    rappresenta_grafo(nodi, collegamenti, colori)               # rappresenta il grafo con pyvis


def trova_nodi (collegamenti):
    """
        Questa funzione trova tutti i nodi presenti nel grafo.
        Utilizzata per controllare che tutti i nodi siano stati visti. Dalla sola scansione del file potrebbe non bastare
    """
    nodi = []

    for nodo, vicino in collegamenti:
        if nodo not in nodi:            # controlla se il nodo è già presente
            nodi.append(nodo)

        if vicino not in nodi:          # controlla se il vicino è già presente
            nodi.append(vicino)

    return nodi


def aggiusta_colori (colori):
    """
        Converte un colore (assegnato da Ocaml) in una stringa hex per pyvis
    """
    def colore_casuale ():
        """
            Genera un colore casuale in formato stringa hex (#rrggbb)
        """
        r = lambda: random.randint(0,255)
        return '#%02X%02X%02X' % (r(),r(),r())

    risultato = []
    scelta = [colore_casuale() for x in range(len(colori))]     # genera una lista di colori casuali (un colore per nodo)
    
    for colore in colori:                                       # assegna il colore alla stringa hex
        risultato.append(scelta[colore])
    
    return risultato


def rappresenta_grafo (nodi, collegamenti, colori):
    """
        Rappresenta il grafo con pyvis.
    """
    net = Network(width='100%', height='600px', directed=False)

    net.add_nodes(nodi, color=colori)
    net.add_edges(collegamenti)

    net.toggle_physics(True)
    net.inherit_edge_colors(False)

    net.show('rappresentazione_grafo.html')


if __name__ == "__main__":
    main(argv[1])
