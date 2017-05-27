all: lexer parser clang

lexer: lex.l
	flex lex.l

parser: parser.y
	bison -d -t -o parser.c parser.y 

clang: 
	gcc parser.c lex.yy.c -o run -ly -ll -DYYDEBUG=1

clean:
	rm parser.c parser.h lex.yy.c run