%{
#include <stdio.h>
#include <stdbool.h>
#include <string.h>
#include <stdlib.h>

extern FILE *yyin;
int yylex (void);
void yyerror (char const *s);
extern int yylineno;
%}

%union {
int tipo_int;
char * tipo_string;
}

%start documento
%token <tipo_string> CABECERA TEXTO NUEVA_LINEA ESPACIO

%% 

documento:
            | bloque documento ;

bloque:   NUEVA_LINEA 
        | contenido NUEVA_LINEA ;

contenido:  cabecera
          | texto;

cabecera:  CABECERA ESPACIO texto;

texto:
        | ESPACIO texto
        | TEXTO texto;

%%

int main(int argc, char *argv[]) {
	printf("\n> Comprobando archivo: %s\n", argv[1]);
	yyin = fopen(argv[1], "r");
	yyparse();
    printf("Sintaxis markdown correcta.\n");
}