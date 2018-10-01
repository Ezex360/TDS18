/*
  Pre-Proyecto Taller de Diseño de Software
  Integrantes:
    Fischer, Sebastian 37128158
    Gardiola, Joaquin 38418091
    Giachero, Ezequiel 39737931
*/

%{

#include <stdlib.h>
#include <string.h>
#include <stdio.h>

#include "calc-sintaxis.tab.h"

void yyerror(char *msg);

%}

%option noyywrap
%option yylineno

letra [a-zA-z]
digito [0-9]
arith_op [+-/%*]
rel_op [<>]


%%

"program"                     { yylval.s=(char *) malloc(sizeof(yytext)*yyleng);
                                strcpy(yylval.s,yytext);
                                //printf("program : %s\n",yytext);
                                return PROGRAM;}

"begin"                       { yylval.s=(char *) malloc(sizeof(yytext)*yyleng);
                                strcpy(yylval.s,yytext);
                                //printf("begin : %s\n",yytext);
                                return BEGINN;}

"end"                         { yylval.s=(char *) malloc(sizeof(yytext)*yyleng);
                                strcpy(yylval.s,yytext);
                                //printf("end : %s\n",yytext);
                                return END;}

"void"                        { yylval.s=(char *) malloc(sizeof(yytext)*yyleng);
                                strcpy(yylval.s,yytext);
                                //printf("void : %s\n",yytext);
                                return VOID;}

"extern"                      { yylval.s=(char *) malloc(sizeof(yytext)*yyleng);
                                strcpy(yylval.s,yytext);
                                //printf("extern : %s\n",yytext);
                                return EXTERN;}

"bool"                        { yylval.s=(char *) malloc(sizeof(yytext)*yyleng);
                                strcpy(yylval.s,yytext);
                                //printf("bool : %s\n",yytext);
                                return BOOL;}

"if"                          { yylval.s=(char *) malloc(sizeof(yytext)*yyleng);
                                strcpy(yylval.s,yytext);
                                //printf("if : %s\n",yytext);
                                return IF;}

"else"                        { yylval.s=(char *) malloc(sizeof(yytext)*yyleng);
                                strcpy(yylval.s,yytext);
                                //printf("else : %s\n",yytext);
                                return ELSE;}

"then"                         { yylval.s=(char *) malloc(sizeof(yytext)*yyleng);
                                strcpy(yylval.s,yytext);
                                //printf("then : %s\n",yytext);
                                return THEN;}

"integer"                      { yylval.s=(char *) malloc(sizeof(yytext)*yyleng);
                                strcpy(yylval.s,yytext);
                                //printf("integer : %s\n",yytext);
                                return INTEGER;}

"return"                      { yylval.s=(char *) malloc(sizeof(yytext)*yyleng);
                                strcpy(yylval.s,yytext);
                                //printf("return : %s\n",yytext);
                                return RETURN;}

"while"                       { yylval.s=(char *) malloc(sizeof(yytext)*yyleng);
                                strcpy(yylval.s,yytext);
                                //printf("while : %s\n",yytext);
                                return WHILE;}

"var"                         { yylval.s=(char *) malloc(sizeof(yytext)*yyleng);
                                strcpy(yylval.s,yytext);
                                //printf("var : %s\n",yytext);
                                return VAR;}

"true"                         { yylval.s=(char *) malloc(sizeof(yytext)*yyleng);
                                strcpy(yylval.s,yytext);
                                //printf("true : %s\n",yytext);
                                return TRUE;}

"false"                         { yylval.s=(char *) malloc(sizeof(yytext)*yyleng);
                                strcpy(yylval.s,yytext);
                                //printf("false : %s\n",yytext);
                                return FALSE;}


{digito}+                     { yylval.i = atoi(yytext);
                                //printf("INT : %d\n",atoi(yytext)); 
                                return INT;}

{letra}({letra}|{digito})*    { yylval.s=(char *) malloc(sizeof(yytext)*yyleng);
                                strcpy(yylval.s,yytext);
                                //printf("ID : %s\n",yytext);
                                return ID;}

{arith_op}|{rel_op}|"="|"!"   { //printf("OPERADOR: %s\n",yytext);
                                return *yytext;}

";"|","|"("|")"               { //printf("COMAS: %s\n",yytext);
                                return *yytext;}

"&&"                          { yylval.s=(char *) malloc(sizeof(yytext)*yyleng);
                                strcpy(yylval.s,yytext);
                                //printf("AND: %s\n",yytext);
                                return AND;}

"||"                          { yylval.s=(char *) malloc(sizeof(yytext)*yyleng);
                                strcpy(yylval.s,yytext);
                                //printf("OR: %s\n",yytext);
                                return OR;}

"=="                          { yylval.s=(char *) malloc(sizeof(yytext)*yyleng);
                                strcpy(yylval.s,yytext);
                                //printf("EQUALS: %s\n",yytext);
                                return EQUALS;}

"//".*\n                      {//printf("Comentario: %s\n",yytext);
                              }

"{"(.|\n)*"}"                 {//printf("Comentario: %s\n",yytext);
                              }

[ \t\n]+|\n                   ;//Ignore whitespace and lineskip

.                             yyerror("Invalid character");



%%


void yyerror(char *msg){
	printf("%s. \nLine: %d\n",msg,yylineno);
}

int main(int argc,char *argv[]){
	++argv,--argc;
	if (argc > 0)
		yyin = fopen(argv[0],"r");
	else
		yyin = stdin;

	yyparse();

}
