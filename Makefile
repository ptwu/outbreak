MODULES=src/country src/main src/virus src/world src/engine src/upgrades src/stats src/command src/converter src/server
OBJECTS=$(MODULES:=.cmo)
TEST=test.byte
MAIN=main.byte
SERVER=server.byte
OCAMLBUILD=ocamlbuild -use-ocamlfind

default: build
	utop

build:
	$(OCAMLBUILD) $(OBJECTS)

buildall:
	cd webapp; npm install
	$(OCAMLBUILD) $(OBJECTS)

test:
	$(OCAMLBUILD) src/$(TEST) && ./$(TEST) -runner sequential

run:
	$(OCAMLBUILD) src/$(SERVER) && ./$(SERVER)& cd webapp; npm start

.PHONY: webapp
webapp:
	cd webapp; npm start

play:
	$(OCAMLBUILD) src/$(MAIN) && ./$(MAIN)

server:
	$(OCAMLBUILD) src/$(SERVER) && ./$(SERVER)

docs: docs-public docs-private
	
docs-public: build
	mkdir -p doc.public
	ocamlfind ocamldoc -I _build/src -short-functors -package ANSITerminal,opium \
	-html -stars -d doc.public $(MODULES:=.ml[i])

docs-private: build
	mkdir -p doc.private
	ocamlfind ocamldoc -I _build/src -short-functors -package ANSITerminal,opium \
	-inv-merge-ml-mli -html -stars -d doc.private $(MODULES:=.ml)  $(MODULES:=.mli)

clean:
	rm -rf _build doc.public doc.private outbreak.zip
	
zip: clean
	zip -r outbreak.zip * .merlin .ocamlinit .gitignore -x webapp/node_modules/\*