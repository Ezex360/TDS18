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

%}

%option noyywrap
%option yylineno

letra [a-zA-z]
digito [0-9]
arith_op [+-/%*]
rel_op [<>]


%%
"var"                     	  { yylval.s=(char *) malloc(sizeof(yytext)*yyleng);
                                strcpy(yylval.s,yytext);
                                printf("VAR : %s\n",yytext);
								                return VAR;}

{digito}+                     { yylval.i = atoi(yytext);
                                printf("INT : %d\n",atoi(yytext)); 
                                return INT;}

{letra}({letra}|{digito})*    { yylval.s=(char *) malloc(sizeof(yytext)*yyleng);
                                strcpy(yylval.s,yytext);
                                printf("ID : %s\n",yytext);
                                return ID;}

{arith_op}                    { yylval.s=(char *) malloc(sizeof(yytext)*yyleng);
                                strcpy(yylval.s,yytext);
                                printf("ARITMETICAL OP : %s\n",yytext);
                                return ARITH_OP;}

{rel_op}|"=="                 { yylval.s=(char *) malloc(sizeof(yytext)*yyleng);
                                strcpy(yylval.s,yytext);
                                printf("RELATIONAL OP : %s\n",yytext);
                                return REL_OP;}

"&&"|"||"                     { yylval.s=(char *) malloc(sizeof(yytext)*yyleng);
                                strcpy(yylval.s,yytext);
                                printf("CONDITIONAL OP : %s\n",yytext);
                                return COND_OP;}

.|\n                          ; /* ignore all the rest */

%%


void yyerror(){
	printf("%s%d\n","-> ERROR Sintactico en la linea: ",yylineno);
}

int main(int argc,char *argv[]){
	++argv,--argc;
	if (argc > 0)
		yyin = fopen(argv[0],"r");
	else
		yyin = stdin;

	yyparse();

}
