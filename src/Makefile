fname = exe
cc = ocamlc
cflags = -c

exe: graphs printer main
	$(cc) graphUtils.cmo printer.cmo main.cmo -o $(fname)


graphs: graphUtils.ml graphUtils.mli
	$(cc) $(cflags) graphUtils.mli graphUtils.ml
	
printer: printer.ml printer.mli
	$(cc) $(cflags) printer.mli printer.ml

main: main.ml main.mli
	$(cc) $(cflags) main.mli main.ml


clear:
	rm -f *.cmi *.cmx *.o *.cmo *.out *.cm*


.PHONY: clear