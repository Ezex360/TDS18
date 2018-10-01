%{

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

%}
 
%union { int i; char *s; }
 
%token<s> PROGRAM
%token<s> BEGINN
%token<s> END
%token<s> VOID
%token<s> EXTERN
%token<s> BOOL
%token<s> IF
%token<s> ELSE
%token<s> THEN
%token<s> INTEGER
%token<s> RETURN
%token<s> WHILE
%token<s> VAR
%token<s> TRUE
%token<s> FALSE
%token<i> INT
%token<s> ID
%token<s> AND
%token<s> OR
%token<s> EQUALS
%token<s> ERR_CHAR


//%type<s> program
//%type<s> var_aux
//%type<s> list_ID
//%type<s> var_decl
//%type<s> method_return
//%type<s> params
//%type<s> method_body
//%type<s> method_decl
//%type<s> block
//%type<s> list_expr
//%type<s> statement
//%type<s> method_call
//%type<s> expr
//%type<s> type
//%type<s> bin_op
//%type<s> arith_op
//%type<s> rel_op
//%type<s> cond_op
%type<s> literal
%type<s> BOOLEAN

%nonassoc '='
%left AND OR
%nonassoc '<' '>' EQUALS
%left '+' '-'
%left '*' '/' '%'
%left UNARY
 
%%

program: PROGRAM BEGINN END {}
       | PROGRAM BEGINN var_decl END {}
       | PROGRAM BEGINN list_method_decl END {}
       | PROGRAM BEGINN var_decl list_method_decl END {}
       ;

type: INTEGER {}
    | BOOL {}
    ;

list_ID: ID {}
       | list_ID ',' ID {}
       ;

var_decl: type list_ID ';' {}
        | var_decl type list_ID ';' {}
        ;

params: type ID {}
       | params ',' type ID {} 
      ;

method_body: block {}
           | EXTERN ';' {}

method_decl: VOID ID '('  ')' method_body {}
           | type ID '('  ')' method_body {}
           | VOID ID '(' params ')' method_body {}
           | type ID '(' params ')' method_body {}
           ;

list_method_decl: method_decl {}
                | list_method_decl method_decl {}

block: BEGINN END
     | BEGINN var_decl END
     | BEGINN list_statement END
     | BEGINN var_decl list_statement END
     ; 

list_statement: statement {}
              | list_statement statement {}

statement: ID '=' expr ';' {}
         | method_call ';' {}
         | IF '(' expr ')' THEN block {}
         | IF '(' expr ')' THEN block ELSE block {}
         | WHILE expr block {}
         | RETURN ';' {}
         | RETURN expr ';' {}
         | ';' {}
         | block {}
         ; 

list_expr: expr {}
         | list_expr ',' expr {}
         ;

method_call: ID '('  ')' {}
           | ID '(' list_expr ')' {}
           ;

expr: ID {}
    | method_call {}
    | literal {}
    | expr '+' expr {}
    | expr '-' expr {}
    | expr '*' expr {}
    | expr '/' expr {}
    | expr '<' expr {}
    | expr '>' expr {}
    | expr '%' expr {}
    | expr AND expr {}
    | expr OR expr {}
    | expr EQUALS expr {}
    | '-' expr %prec UNARY {}
    | '!' expr %prec UNARY {}
    | '(' expr ')'
    ;

literal: INT {}
       | BOOLEAN {}
       ;

BOOLEAN: TRUE {}
       | FALSE {}
       ; 

/*
bin_op: arith_op {}
      | rel_op {}
      | cond_op {}
      ;

arith_op: '+' {}
        | '-' {}
        | '*' {}
        | '/' {}
        | '%' {}
        ;

rel_op: '<' {}
      | '>' {}
      | EQUALS {}
      ;

cond_op: AND {}
       | OR {}
       ;
*/

%%
