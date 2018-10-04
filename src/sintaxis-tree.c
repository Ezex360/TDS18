#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "definitions.h"

node * root;


/* --- IMPLEMENTACION DE FUNCIONES --- */
/**
 * Funcion para crear un nuevo nodo, con hijos y hermanos null
 */
node * new_node(char * data){
	//Reservo espacio de memoria
    node *new_node = (node *) malloc(sizeof(node));
    //Cargo el nodo
    new_node->next = NULL;
    new_node->child = NULL;
    new_node->data = data;
    //Retorno el nodo
    return new_node;
}

/**
 * Funcion que agrega un hermano al final de la lista de hermanos del nodo
 * pasado por parametro.
 */
node * add_sibling(node * n, node * sibling){
	//Si el parametro es vacio no se puede agregar el hermano
    if ( n == NULL )
        return NULL;
    //Sino busco el final de la lista de hermanos y lo agrego
    while (n->next)
        n = n->next;
    return (n->next = sibling);
}

/**
 * Funcion que agrega un hijo al nodo pasado por parametro.
 */
node * add_child(node * n, node * child){
	//Si el parametro es vacio no se puede agregar el hijo
    if ( n == NULL )
        return NULL;
    //Sino, lo agrego a la lista de hijos
    if ( n->child )
        return add_sibling(n->child, child);
    else
        return (n->child = child);
}

/**
 * Funcion para liberar el espacio de los nodos almacenados
 * en la memoria.
 */
void remove_node(node* n){

    if(n->next)
        remove_node(n->next);

    if(n->child)
        remove_node(n->child);

    free(n);
}

void print_dfs(node * n){

	printf("%s ",n->data);

    if(n->child){
    	print_dfs(n->child);
    }
	if(n->next){
        print_dfs(n->next);
	}


}

void init_tree(char * data){
	remove_node(root);
	root = new_node(data); 
}
/*
int main(int argc, char const *argv[])
{
	init_tree("1");
	node * aux1;
	node * aux2;
	aux1 = add_child(root,"2");
	aux2 = add_sibling(aux1,"3");
	aux1 = add_child(aux1,"4");
	aux2 = add_child(aux2,"5");
	print_dfs(root);
	printf("\n");
	return 0;
}
*/
