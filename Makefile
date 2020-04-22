test:
	ocamlbuild -use-ocamlfind src/test.byte && ./test.byte -runner sequential

play:
	ocamlbuild -use-ocamlfind src/main.byte

docs:
	mkdir -p doc
	ocamldoc -d doc -html src/*.ml

clean:
	ocamlbuild -clean
	rm -rf doc
