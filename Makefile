exe: printer main
	ocamlc printer.cmo main.cmo -o exe
	./exe

printer: printer.ml printer.mli
	ocamlc -c printer.mli
	ocamlc -c printer.ml

main: main.ml main.mli
	ocamlc -c main.mli
	ocamlc -c main.ml

clear:
	rm -f *.cmi *.cmx *.o *.cmo *.out *.cm*

.PHONY: clear