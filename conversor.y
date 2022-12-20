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
void escribir_pdf(char * tipo, int opcion[]);
extern int yylineno;
%}

%union {
int tipo_int;
char * tipo_string;
}

%start documento
%token <tipo_string> CABECERA1 CABECERA2 CABECERA3 CABECERA4 CABECERA5
%token <tipo_string> TEXTO TEXTO_NEGRITA TEXTO_CURSIVA
%token <tipo_string> NUEVA_LINEA ESPACIO
%token <tipo_string> CODIGO

%% 

documento:  bloque
          | bloque documento
          | ;



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
    //output_result en output Mirar como devolver el pdf resultado
    printf("Correct markdown syntax\n");
    return result;
}

int yyerror(const char* s){
    extern char *yytext;
    printf("error while parsing line %d: %s at '%s', ASCII code: %d\n", yylineno, s, yytext, (int)(*yytext));
    exit(1);
}

int escribir_pdf() {
  HPDF_Doc  pdf;
  HPDF_Page page;

  pdf = HPDF_New(NULL, NULL);
  if (!pdf) {
    printf("error: cannot create PdfDoc object\n");
    return 1;
  }

  /* Añadir nuevo objeto pagina */
  page = HPDF_AddPage(pdf);

  /* Dibujar una linea */
  HPDF_Page_MoveTo(page, 50, 50);
  HPDF_Page_LineTo(page, 250, 50);
  HPDF_Page_Stroke(page);

  /* Escribir un texto */
  HPDF_Page_BeginText(page);
  HPDF_Page_MoveTextPos(page, 50, 55);
  HPDF_Page_ShowText(page, "Hello, World!");
  HPDF_Page_EndText(page);

  /* Guardar el documento */
  HPDF_SaveToFile(pdf, "output.pdf");

  /* Limpiar */
  HPDF_Free(pdf);

  return 0;
}