%{

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#define LIMIT 16

%}
 
%union { int i; char *s; }
 
%token<i> INT
%token<s> ID
%token<s> VAR
%token<s> ARITH_OP
%token<s> REL_OP
%token<s> COND_OP



%type<s> Test 
%type<s> Bin_OP 

 
%left '+'
%left '*'
 
%%

Test: Bin_OP {printf("Binary operator found\n");} //Listo
    | VAR {printf("VAR found: %s\n",$1);} //Listo
    ;

Bin_OP: ARITH_OP {printf("Aritmetic operator found: %s\n",$1 );} //Listo
      | REL_OP {printf("Relational operator found : %s\n",$1);} //Listo
      | COND_OP {printf("Relational operator found : %s\n",$1);} //Listo
      ;

%%
