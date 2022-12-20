%{
    #include <stdlib.h>
    #include <stdio.h>
    #include "y.tab.h"
    #include <stdbool.h>

    bool negrita = false;
    bool cursiva = false;
%}

%option noyywrap
%option yylineno

TODO: cabcera

cabecera1 \#[ ][^\#\n]*\n
cabecera2 \#\#[ ][^\#\n]*\n
cabecera3 \#\#\#[ ][^\#\n]*\n
cabecera4 \#\#\#\#[ ][^\#\n]*\n
cabecera5 \#\#\#\#\#[ ][^\#\n]*\n
negrita \*\*[^\*]*\*\*
cursiva \_[^\_]*\_
codigo \`\`\`[^\`]*\`\`\`
texto ^[^#\n\*\_][^\n]*\n
espacio [ \t]+
nueva_linea [\n]+{espacio}[\n]+

%%
{cabecera1}                                  {yylval.tipo_string = strdup(yytext); return CABECERA1;}
{cabecera2}                                  {yylval.tipo_string = strdup(yytext); return CABECERA2;}
{cabecera3}                                  {yylval.tipo_string = strdup(yytext); return CABECERA3;}
{cabecera4}                                  {yylval.tipo_string = strdup(yytext); return CABECERA4;}
{cabecera5}                                  {yylval.tipo_string = strdup(yytext); return CABECERA5;}
{negrita}                                   {yylval.tipo_string = strdup(yytext); return TEXTO_NEGRITA;}
{cursiva}                                   {yylval.tipo_string = strdup(yytext); return TEXTO_CURSIVA;}
{codigo}                                    {yylval.tipo_string = strdup(yytext); return CODIGO;}
{texto}                                     {yylval.tipo_string = strdup(yytext); return TEXTO;}
{espacio}                                   {yylval.tipo_string = strdup(yytext); return ESPACIO;}
{nueva_linea}                               {yylval.tipo_string = strdup(yytext); return NUEVA_LINEA;}
;                                           {/*Ignora otros caracteres*/}
%%