cc = ocamlc
cflags = -c
cinclude = -I src

srcdir = src
buildir = build
bindir = bin

target = $(bindir)/exe

.PHONY: clear

all: cartelle $(target)


$(target): $(buildir)/graphUtils.cmo $(buildir)/printer.cmo $(buildir)/data.cmo $(buildir)/main.cmo
	$(cc) -o $@ $^
	cp $(srcdir)/rappresentazione_grafo/rappresentazione_grafo.py $(bindir)


$(buildir)/graphUtils.cmo: $(srcdir)/graphUtils.mli $(srcdir)/graphUtils.ml 
	$(cc) $(cinclude) $(cflags) $^
	mv $(srcdir)/graphUtils.cmo $(buildir)
	
$(buildir)/printer.cmo: $(srcdir)/printer.mli $(srcdir)/printer.ml
	$(cc) $(cinclude) $(cflags) $^
	mv $(srcdir)/printer.cmo $(buildir)

$(buildir)/data.cmo: $(srcdir)/data.mli $(srcdir)/data.ml
	$(cc) $(cinclude) $(cflags) $^
	mv $(srcdir)/data.cmo $(buildir)

$(buildir)/main.cmo: $(srcdir)/main.mli $(srcdir)/main.ml
	$(cc) $(cinclude) $(cflags) $^
	mv $(srcdir)/main.cmo $(buildir)



cartelle: $(buildir) $(bindir)

$(buildir):
	mkdir -p $@

$(bindir):
	mkdir -p $@



clear:
	rm -f $(buildir)/*.cmo
	rm -rf $(bindir)/*
	rm -f $(srcdir)/*.cmi
