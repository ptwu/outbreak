MODULES=src/country src/engine src/main src/virus src/world
OBJECTS=$(MODULES:=.cmo)
TEST=src/test.byte
MAIN=src/main.byte
OCAMLBUILD=ocamlbuild -use-ocamlfind

default: build
	utop

build:
	$(OCAMLBUILD) $(OBJECTS)

test:
	$(OCAMLBUILD) src/test.byte && ./test.byte -runner sequential

play:
	build && ./$(MAIN)
	
docs: build
	mkdir -p docs
	ocamlfind ocamldoc -I _build -package yojson,ANSITerminal \
		-html -stars -d docs src/*.ml[i]

clean:
	ocamlbuild -clean
	rm -rf docs
