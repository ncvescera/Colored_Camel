<img src="relazione/Colored Camel_files/logo.png" width="100%" />

## Prerequisiti:

### Utilizzando Docker

All'interno di questo progetto è presente un _devcontainer_ che contiene tutto il 
necessario per far eseguire il progetto e mette a disposizione anche un server Jupyter
con un kernel di OCaml il gradi di eseguire codice.

Sarà quindi necessaria solo una versione funzionante di docker (testo con la _20.10.18_)


### Io odio Docker !

Se non hai a disposizione una versione di docker funzionante dovrai installare le
dipendenze a mano e sarà necessario:

- OCaml (con anche ocamlc)
- Python 3.x
    - pyvis (`pip install pyvis`)
- Se vuoi anche utilizzare il notebook dovrai dotarti di un server Jupyter che sia in 
grado di eseguire il [kernel OCaml](https://akabe.github.io/ocaml-jupyter/).

## Building

Per compilare il progetto eseguire i seguenti comandi:

```bash
cd progetto
make
```

E' possibile ripulire dall'esecuzione di `make` con: `make clear`.

## Esecuzione

### Jupyter

Se utilizzi il devcontainer, una volta avviato potrai lanciare il server Jupyter per
poter utilizzare il notebook con il seguente comando:

```bash
jupyter notebook
```

### CLI

Per avviare il progetto da terminale eseguire i seguenti comandi 
(ovviamente solo dopo averlo compilato):

```
cd bin
./exe
```

**N.B.**: *E' richiesto che il terminale sui cui viene eseguito supporti la visualizzazione delle emoji !!*