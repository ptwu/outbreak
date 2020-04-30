MODULES=src/country src/engine src/main src/virus src/world src/main src/command src/example
OBJECTS=$(MODULES:=.cmo)
TEST=test.byte
MAIN=main.byte
SERVER=example.byte
OCAMLBUILD=ocamlbuild -use-ocamlfind

default: build
	utop

build:
	$(OCAMLBUILD) $(OBJECTS)

buildall:
	cd webapp; npm install && npm run build
	$(OCAMLBUILD) $(OBJECTS)

test:
	$(OCAMLBUILD) src/$(TEST) && ./$(TEST) -runner sequential

play:
	$(OCAMLBUILD) src/$(MAIN) && ./$(MAIN)

server:
	$(OCAMLBUILD) src/$(SERVER) && ./$(SERVER)
	
docs: build
	mkdir -p docs
	ocamlfind ocamldoc -I _build -package yojson,ANSITerminal \
		-html -stars -d docs src/*.ml[i]

clean:
	ocamlbuild -clean
	rm -rf docs
	
zip:
	ocamlbuild -clean && zip -r outbreak.zip * .merlin .ocamlinit .gitignore -x webapp/node_modules/\*