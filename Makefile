MODULES=src/country src/engine src/main src/virus src/world src/main src/command
OBJECTS=$(MODULES:=.cmo)
TEST=test.byte
MAIN=main.byte
OCAMLBUILD=ocamlbuild -use-ocamlfind

default: build
	utop

build:
	$(OCAMLBUILD) $(OBJECTS)

test:
	$(OCAMLBUILD) src/$(TEST) && ./$(TEST) -runner sequential

play:
	$(OCAMLBUILD) src/$(MAIN) && ./$(MAIN)

play2:
	src/main.byte
	
docs: build
	mkdir -p docs
	ocamlfind ocamldoc -I _build -package yojson,ANSITerminal \
		-html -stars -d docs src/*.ml[i]

clean:
	ocamlbuild -clean
	rm -rf docs
