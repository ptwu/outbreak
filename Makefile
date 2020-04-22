MODULES=src/*
OBJECTS=$(MODULES:=.cmo)
TEST=src/test.byte
MAIN=src/main.byte
OCAMLBUILD=ocamlbuild -use-ocamlfind

default: build
	utop

build:
	$(OCAMLBUILD) $(MAIN)

test:
	$(OCAMLBUILD) -tag 'debug' $(TEST) && ./$(TEST) -runner sequential

play:
	build && ./$(MAIN)
	
docs: build
	mkdir -p docs
	ocamlfind ocamldoc -I _build -package yojson,ANSITerminal \
		-html -stars -d docs src/*.ml[i]

clean:
	ocamlbuild -clean
	rm -rf docs
