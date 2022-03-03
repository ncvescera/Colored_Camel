cc = ocamlc
cflags = -c
cinclude = -I src

srcdir = src
buildir = build
bindir = bin

target = $(bindir)/exe

.PHONY: clear

all: $(target)

$(target): $(buildir)/graphUtils.cmo $(buildir)/printer.cmo $(buildir)/data.cmo $(buildir)/main.cmo
	mkdir -p $(bindir) $(buildir)
	mv $(srcdir)/*.cmo $(buildir)
	$(cc) -o $@ $^
	cp $(srcdir)/rappresentazione_grafo/rappresentazione_grafo.py $(bindir)


$(buildir)/graphUtils.cmo: $(srcdir)/graphUtils.mli $(srcdir)/graphUtils.ml 
	$(cc) $(cinclude) $(cflags) $^
	
$(buildir)/printer.cmo: $(srcdir)/printer.mli $(srcdir)/printer.ml
	$(cc) $(cinclude) $(cflags) $^

$(buildir)/data.cmo: $(srcdir)/data.mli $(srcdir)/data.ml
	$(cc) $(cinclude) $(cflags) $^

$(buildir)/main.cmo: $(srcdir)/main.mli $(srcdir)/main.ml
	$(cc) $(cinclude) $(cflags) $^


clear:
	rm -f $(buildir)/*.cmo
	rm -f $(bindir)/*
	rm -f $(srcdir)/*.cmi


