%{
    #include <stdlib.h>
    #include <stdio.h>
    #include "y.tab.h"
%}

%option noyywrap
%option yylineno

letra [a-zA-Z]
numero [0-9]+
palabra {letra}
espacio [ \t]+
nueva_linea [\n]+{espacio}[\n]+
cabecera #|##|###|####|#####

%%

{cabecera}                                                   {yylval.tipo_string = strdup(yytext); return CABECERA;}
({palabra}|{numero})                                        {yylval.tipo_string = strdup(yytext); return TEXTO;}
{nueva_linea}                                               {yylval.tipo_string = strdup(yytext); return NUEVA_LINEA;}
{espacio}                                                   {yylval.tipo_string = strdup(yytext); return ESPACIO;}
                                                          ; {/*Ignora otros caracteres*/}
%%