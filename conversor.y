%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "y.tab.h"
#include <hpdf.h>


extern FILE *yyin;
FILE * output;
int yylex (void);
int yyerror (char const *s);
int escribir_pdf();
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

s: documento;

documento:  bloque
          | bloque documento;

bloque: cabecera
     | parrafo;

parrafo: texto;

cabecera:  CABECERA1
         | CABECERA2
         | CABECERA3
         | CABECERA4
         | CABECERA5; 

texto:  TEXTO
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
    printf("Correct markdown syntax\n");
    return result;
}

int yyerror(const char* s){
    extern char *yytext;
    printf("error while parsing line %d: %s at '%s', ASCII code: %d\n", yylineno, s, yytext, (int)(*yytext));
    exit(1);
}

int escribir_pdf() { /*Utilizar funciones LibHaru*/

  HPDF_Doc  pdf;
  HPDF_Page page_1;

  pdf = HPDF_New(NULL, NULL);
  if (!pdf) {
    printf("error: cannot create PdfDoc object\n");
    return 1;
  }

  /* Añadir nuevo objeto pagina */
  page_1 = HPDF_AddPage (pdf);

  /* Dibujar una linea */


  /* Escribir un texto */


  /* Guardar el documento */
  HPDF_SaveToFile (pdf, "salida.pdf"); //Deberia guardarse en el directorio actual

  /* Limpiar */
  HPDF_Free (pdf);
  return 0;
}