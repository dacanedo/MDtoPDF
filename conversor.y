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
extern int yylineno;
HPDF_Doc  pdf;                              /*Creo el pdf que luego devolvere*/                           
HPDF_Page page_1;
int x = 30;
void substring(char s[], char sub[], int p, int l);


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

parrafo: texto

cabecera:  CABECERA1 {HPDF_Font font = HPDF_GetFont(pdf, "Helvetica", NULL);
                      HPDF_Page_SetFontAndSize(page_1, font, 30);
                      HPDF_Page_BeginText(page_1);
                      HPDF_Page_SetLineWidth(page_1, 80);
                      HPDF_Page_TextOut(page_1, 60, HPDF_Page_GetHeight(page_1)-x, $1+2);
                      x=x+50;
                      printf("%d", x);
                      HPDF_Page_EndText(page_1);}
         | CABECERA2 {HPDF_Font font = HPDF_GetFont(pdf, "Helvetica", NULL);
                      HPDF_Page_SetFontAndSize(page_1, font, 26);
                      HPDF_Page_BeginText(page_1);
                      HPDF_Page_SetLineWidth(page_1, 80);
                      HPDF_Page_TextOut(page_1, 60, HPDF_Page_GetHeight(page_1)-x, $1+3);
                      x=x+50;
                      printf("%d", x);
                      HPDF_Page_EndText(page_1);}
         | CABECERA3 {HPDF_Font font = HPDF_GetFont(pdf, "Helvetica", NULL);
                      HPDF_Page_SetFontAndSize(page_1, font, 22);
                      HPDF_Page_BeginText(page_1);
                      HPDF_Page_SetLineWidth(page_1, 80);
                      HPDF_Page_TextOut(page_1, 60, HPDF_Page_GetHeight(page_1)-x, $1+4);
                      x=x+50;
                      printf("%d", x);
                      HPDF_Page_EndText(page_1);}
         | CABECERA4 {HPDF_Font font = HPDF_GetFont(pdf, "Helvetica", NULL);
                      HPDF_Page_SetFontAndSize(page_1, font, 18);
                      HPDF_Page_BeginText(page_1);
                      HPDF_Page_SetLineWidth(page_1, 80);
                      HPDF_Page_TextOut(page_1, 60, HPDF_Page_GetHeight(page_1)-x, $1+5);
                      x=x+50;
                      printf("%d", x);
                      HPDF_Page_EndText(page_1);}
         | CABECERA5 {HPDF_Font font = HPDF_GetFont(pdf, "Helvetica", NULL);
                      HPDF_Page_SetFontAndSize(page_1, font, 14);
                      HPDF_Page_BeginText(page_1);
                      HPDF_Page_SetLineWidth(page_1, 80);
                      HPDF_Page_TextOut(page_1, 60, HPDF_Page_GetHeight(page_1)-x, $1+6);
                      x=x+50;
                      printf("%d", x);
                      HPDF_Page_EndText(page_1);};

texto: TEXTO_NEGRITA   {
                      char * cadena = malloc(800);
                      substring($1, cadena, 3, strlen($1)-4);
                      HPDF_Font font = HPDF_GetFont(pdf, "Helvetica-Bold", NULL);
                      HPDF_Page_SetFontAndSize(page_1, font, 10);
                      HPDF_Page_BeginText(page_1);
                      HPDF_Page_SetLineWidth(page_1, 80);
                      HPDF_Page_TextOut(page_1, 60, HPDF_Page_GetHeight(page_1)-x, cadena);
                      x=x+20;
                      printf("%d", x);
                      HPDF_Page_EndText(page_1);};
     | TEXTO_CURSIVA   {char * cadena = malloc(800);
                      substring($1, cadena, 2, strlen($1)-2);
                      HPDF_Font font = HPDF_GetFont(pdf, "Helvetica-Oblique", NULL);
                      HPDF_Page_SetFontAndSize(page_1, font, 10);
                      HPDF_Page_BeginText(page_1);
                      HPDF_Page_SetLineWidth(page_1, 80);
                      HPDF_Page_TextOut(page_1, 60, HPDF_Page_GetHeight(page_1)-x, cadena);
                      x=x+20;
                      printf("%d", x);
                      HPDF_Page_EndText(page_1);};
     | CODIGO          {char * cadena = malloc(800);
                      substring($1, cadena, 4, strlen($1)-7);
                      HPDF_Font font = HPDF_GetFont(pdf, "Helvetica", NULL);
                      HPDF_Page_SetFontAndSize(page_1, font, 12);
                      HPDF_RGBColor grey = {0.5, 0.5, 0.5};
                      HPDF_Page_SetRGBFill(page_1, grey.r, grey.g, grey.b);
                      HPDF_Page_Rectangle(page_1, 50, 50, 200, 100);
                      HPDF_Page_Fill(page_1);
                      HPDF_Page_BeginText(page_1);
                      HPDF_Page_SetLineWidth(page_1, 80);
                      HPDF_Page_TextOut(page_1, 60, HPDF_Page_GetHeight(page_1)-x, cadena);
                      x=x+20;
                      printf("%d", x);
                      HPDF_Page_EndText(page_1);};
     | TEXTO           {
                      HPDF_Font font = HPDF_GetFont(pdf, "Helvetica", NULL);
                      HPDF_Page_SetFontAndSize(page_1, font, 10);
                      HPDF_Page_BeginText(page_1);
                      HPDF_Page_SetLineWidth(page_1, 80);
                      HPDF_Page_TextOut(page_1, 60, HPDF_Page_GetHeight(page_1)-x, $1);
                      x=x+20;
                      printf("%d", x);
                      HPDF_Page_EndText(page_1);};

%%

int main(int argc, char *argv[]) {
    FILE *fconfig = fopen(argv[1], "r");
    if (!fconfig) {
        printf("Error reading file!\n");
        return -1;
    }
    yyin = fconfig;

    pdf = HPDF_New(NULL, NULL);
                if (!pdf) {
                    printf("error: no se puede crear el objeto PdfDoc\n");
                    return 1;
                };       
    page_1 = HPDF_AddPage (pdf);
    HPDF_Font font = HPDF_GetFont(pdf, "Helvetica", NULL);
    HPDF_Page_SetFontAndSize(page_1, font, 20);
  

    int result = yyparse();                         /*Aqui llamo al parser*/
    printf("Sintaxis Markdown correcta\n");         /*Siempre va a ser correcta*/
    HPDF_SaveToFile (pdf, "salida.pdf");            /*Deberia guardarse en el directorio actual*/
    return result;
}

int yyerror(const char* s){
    extern char *yytext;
    printf("error while parsing line %d: %s at '%s', ASCII code: %d\n", yylineno, s, yytext, (int)(*yytext));
    exit(1);
}

void substring(char s[], char sub[], int p, int l) {
   int c = 0;
   
   while (c < l) {
      sub[c] = s[p+c-1];
      c++;
   }
   sub[c] = '\0';
}