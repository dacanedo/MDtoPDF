%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

extern FILE *yyin;
FILE * output;
int yylex (void);
int yyerror (char const *s);
void escribir_pdf(char * tipo, int opcion[]);
extern int yylineno;
%}

%union {
int tipo_int;
char * tipo_string;
}

%start s
%token <tipo_string> CABECERA TEXTO NUEVA_LINEA ESPACIO

%% 

s: documento;

documento:  /*Vacio*/
          | documento parrafo;

parrafo:  NUEVA_LINEA parrafo //Aqui la opcion de escribir pdf no hace nada asi que pongo 0
        | contenido parrafo  //AQUI AÑADE CONTENIDO
        | ;

contenido:  cabecera
          | texto; //AQUI GENERA PARRAFO (TEXTO)

cabecera: CABECERA ESPACIO texto;  //AQUI GENERA CABECERA

texto:  TEXTO NUEVA_LINEA texto  //AQUI JUNTA $1 Y $3 CREO
      | TEXTO ESPACIO texto; //AQUI JUNTA $1 Y $3 CREO
      | TEXTO
      | ;  

%%

int main(int argc, char *argv[]) {
    FILE *fconfig = fopen(argv[1], "r");
    if (!fconfig) {
        printf("Error reading file!\n");
        return -1;
    }
    yyin = fconfig;
    int result = yyparse();
    //output_result en output Mirar como devolver el pdf resultado
    printf("Correct markdown syntax\n");
    return result;
}

int yyerror(const char* s){
    extern char *yytext;
    printf("error while parsing line %d: %s at '%s', ASCII code: %d\n", yylineno, s, yytext, (int)(*yytext));
    exit(1);
}

void escribir_pdf(char * tipo, int opcion[]) { //Esta funcion va a ir escribiendo en el pdf lo que se va leyendo del markdown
//Alomejor necesito de alguna libreria para escribir pdfs
}