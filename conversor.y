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
%token <tipo_string> CABECERA1 CABECERA2 CABECERA3 CABECERA4 CABECERA5
%token <tipo_string> TEXTO TEXTO_NEGRITA TEXTO_CURSIVA
%token <tipo_string> NUEVA_LINEA ESPACIO
%token <tipo_string> CODIGO

%% 

documento: bloque*

bloque: cabecera
     | parrafo;

parrafo: texto '\n'

cabecera:  CABECERA1
         | CABECERA2
         | CABECERA3
         | CABECERA4
         | CABECERA5; 

text:  TEXTO
     | TEXTO_NEGRITA
     | TEXTO_CURSIVA
     | CODIGO;

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