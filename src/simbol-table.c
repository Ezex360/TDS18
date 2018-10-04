#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "definitions.h"

stack * pila;

/* --- IMPLEMENTACION DE FUNCIONES --- */
variable * new_var(char * tipo, char * nombre, char * valor){
    variable * aux = (variable *) malloc(sizeof(variable));
    aux->type = tipo;
    aux->name = nombre;
    aux->value = valor;
    return aux;
}

void add_var(char * level, variable var){
    stack * pos_l = find_level(level);
    list * pos_v = find_var(level,var.name);
    list * add = (list *) malloc(sizeof(list)+sizeof(variable));
    add->var = var;
    add->next = NULL;
    if(pos_v != NULL){
        if(strcmp(var.type,pos_v->var.type) !=0){
            printf("ERROR\n");
            exit(0);
        }else{
            pos_v->var.value = var.value;
        }

    }
    if(pos_l != NULL){
        list * reco = pos_l->var_list;
        while(reco->next)
            reco = reco->next;
        reco->next = add;
    }
    stack * reco = pila;
    while(reco->next)
        reco = reco->next;
    stack * new_level = (stack *) malloc(sizeof(stack));
    new_level->name = level;
    new_level->var_list = add;
    new_level->next = NULL;
    reco->next = new_level;
}

list * find_var(char * level, char * var){
    stack * nivel = find_level(level);
    if(nivel == NULL)
        return NULL;
    list * reco = nivel->var_list;
    while(strcmp(reco->var.name,level)!=0 && reco->next != NULL)
        reco = reco ->next;
    if(strcmp(reco->var.name,level) == 0 )
        return reco;
    else
        return NULL;
}


stack * find_level(char * level){
    stack * reco = pila;
    while(strcmp(reco->name,level)!=0 && reco->next != NULL)
        reco = reco ->next;
    if(strcmp(reco->name,level) == 0 )
        return reco;
    else
        return NULL;
}

void free_stack(stack * s){
    while(s->next)
        free_stack(s->next);

    free_list(s->var_list);

    free(s);
}

void free_list(list * l){
    while(l->next)
        free_list(l->next);

    free(l);
}

void init_stack(){
    free_stack(pila);
    pila = (stack *) malloc(sizeof(stack)); 
}

/*
int main(int argc, char const *argv[])
{
*/
