JAVA_FILE = com/github/tudny/algo/ShortestPath
C_FILE = src_c/shortest_path
OCAML_FILE = src_ocaml/shortest_path

GEN_FILE = gen/gen

.PHONY : all runJava runC runOcaml gen

all : $(JAVA_FILE).class $(C_FILE) $(OCAML_FILE) $(GEN_FILE) Makefile

$(JAVA_FILE).class : $(JAVA_FILE).java
	javac $(JAVA_FILE).java

runJava : $(JAVA_FILE).class
	java $(JAVA_FILE)

runJavaXint: $(JAVA_FILE).class
	java $(JAVA_FILE) -Xint

$(C_FILE) : $(C_FILE).c
	gcc -Wall -Wextra -O2 -o $(C_FILE) $(C_FILE).c

runC : $(C_FILE)
	./$(C_FILE)

$(OCAML_FILE) : $(OCAML_FILE).ml
	ocamlopt -o $(OCAML_FILE) $(OCAML_FILE).ml

runOcaml : $(OCAML_FILE)
	./$(OCAML_FILE)

clean :
	@find . -name "*.class" -type f -delete
	@rm -f $(C_FILE)
	@rm -f $(OCAML_FILE) $(OCAML_FILE).cmi $(OCAML_FILE).cmx $(OCAML_FILE).o
	@rm -f gen/gen

$(GEN_FILE) : $(GEN_FILE).c
	gcc -Wextra -Wall -o $(GEN_FILE) $(GEN_FILE).c

runGen : $(GEN_FILE)
	./$(GEN_FILE)
