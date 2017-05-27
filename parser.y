%{
#include<stdio.h>
#include<stdlib.h>
#include <math.h>
#include <string.h>



extern int yylex();
extern int yyparse();
extern FILE *yyin;

%}


%left    OP_ADD OP_SUB
%left    OP_MUL OP_DIV

%left    OP_GT OP_LT OP_EQ OP_NE OP_LE OP_GE


%token   OP_ASSIGN
%token   IDENTIFIER


%token	INT_CONSTANT
%token	FLOAT_CONSTANT

%token   SEMICOLON
%token   COMMA

%token   LBRACE
%token   RBRACE
%token   LPAREN
%token   RPAREN

%token LBRACKETS
%token RBRACKETS

%token   KW_INT
%token   KW_BLN
%token   KW_REEL

%token	 OP_ET
%token	 OP_OU

%token   KW_SI
%token   KW_ALORS
%token   KW_SINON
%token   KW_FINSI


%token   KW_POUR
%token   KW_FINPOUR
%token   KW_DE

%token   KW_FAIRE

%token   KW_ALGO
%token   KW_DEBUT
%token   KW_FIN

%token   KW_LIRE
%token   KW_AFFICHER

%token	 STR

%start program

%%


program : KW_ALGO IDENTIFIER declarations KW_DEBUT exprs KW_FIN { printf("Syntaxe accepté\n");};

declarations : | declaration | declaration declarations;

declaration :type LBRACKETS INT_CONSTANT RBRACKETS decIdent SEMICOLON | type decIdent SEMICOLON;
decIdent: IDENTIFIER
		| IDENTIFIER COMMA decIdent
		;


type: KW_INT
	| KW_BLN
	| KW_REEL

exprs: | expr | expr exprs;
expr : KW_LIRE IDENTIFIER SEMICOLON 
	| KW_AFFICHER STR SEMICOLON
	| KW_AFFICHER IDENTIFIER SEMICOLON
	| IDENTIFIER OP_ASSIGN IDENTIFIER SEMICOLON
	| IDENTIFIER OP_ASSIGN math SEMICOLON
	| IDENTIFIER OP_ASSIGN comparison SEMICOLON
	| pourexp
	| siexpr
	;


pourexp : KW_POUR IDENTIFIER KW_DE intorident COMMA intorident KW_FAIRE exprs KW_FINPOUR;

intorident : INT_CONSTANT 
			| IDENTIFIER;

siexpr : KW_SI condition KW_ALORS exprs KW_FINSI | KW_SI condition KW_ALORS exprs KW_SINON exprs KW_FINSI;

condition : | LPAREN condition RPAREN | condition OP_ET condition | condition OP_OU condition | comparison;

comparison: intorident cmpop intorident;

cmpop : OP_GT | OP_LT | OP_EQ | OP_NE | OP_LE | OP_GE;

math : | LPAREN math RPAREN
	| math OP_MUL math
	| math OP_DIV math
	| math OP_ADD math
	| math OP_SUB math
	| IDENTIFIER
	| FLOAT_CONSTANT
	| INT_CONSTANT;


%%

int main(void) {

	yyin = freopen("in.txt","r",stdin);
	yyparse();
}

int yywrap()
{
return 1;
}


int yyerror(char *s){
	printf( "%s\n", s);
}
