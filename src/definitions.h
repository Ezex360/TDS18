#ifndef DEFINITIONS_H_ 
#define DEFINITIONS_H_  
/* TABLA DE SIMBOLOS */
/* --- DECLARACION DE TIPOS  --- */

/**
 * Estructura de variables
 */
typedef struct variable{
    char * type;
    char * name;
    char * value;
}variable;

/**
 * Estructura de nodos
 */
typedef struct list{
    variable var;
    struct list * next;
}list;

/**
 * Pila de lista de variables
 */
typedef struct stack{
    char * name;
    list * var_list;
    struct stack * next; 
}stack;

/* --- DECLARACION DE FUNCIONES --- */
void add_var(char * level, variable var);
variable * new_var(char * tipo, char * nombre, char * valor);
list * find_var(char * level, char * var);
stack * find_level(char * level);
void free_stack(stack * s);
void free_list(list * l);
void init_stack();

/* ARBOL DE SINTAXIS */
/* --- DECLARACION DE TIPOS  --- */
/**
 * Estructura de Arbol N-Ario
 */
typedef struct nary_tree{
	char * data;
	struct nary_tree * next; //hermanos
	struct nary_tree * child; //hijos
}node;

/* --- DECLARACION DE FUNCIONES --- */
node * new_node(char *);
node * add_sibling(node *, node *);
node * add_child(node *, node *);
void remove_node(node* node);
void print_dfs(node * n);
void init_tree(char * data);


#endif 