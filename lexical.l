
%{
#include <stdio.h>
#include <stdlib.h>
#include "syntax.tab.h"
%}
%option yylineno
INT_DEX ([1-9][0-9]*)|[0]
INT_HEX [0][Xx]([1-9][0-9]*)|[0]
INT_OCT [0]([1-7][0-7]*)|[0]
INT {INT_DEX}|{INT_HEX}|{INT_OCT}
FLOAT [+-]?[0-9]+[.][0-9]+([Ee][+-]?[0-9]*|[0])?[f]?
ID ([a-zA-Z]|[_])[a-zA-Z]*|[0-9]*{1,31}
SEMI [;]
COMMA [,]
ASSIGNOP [=]
RELOP [>]|[<]|[>][=]|[<][=]|[=][=]|[!][=]
PLUS [+]
MINUS [-]
STAR [*]
DIV [/]
AND [&][&]
OR [|][|]
DOT [.]
NOT [!]
TYPE int|float
LP \(
RP \)
LB \[
RB \]
LC \{
RC \}
STRUCT struct
RETURN return
IF if
ELSE else
WHILE while
SPACE [ \t\r]*
EOL \n
TRANS [/][/]
PERROR .
%%
{TRANS} {char c=input(); while(c!='\n') c=input();printf("\n");}
{EOL} {printf("\n");}
{INT} {yylval.a=newast("INT",0,yylineno);return INT;}
{FLOAT} {yylval.a=newast("FLOAT",0,yylineno);return FLOAT;}
{SEMI} {yylval.a=newast("SEMI",0,yylineno);return SEMI;}
{COMMA} {yylval.a=newast("COMMA",0,yylineno);return COMMA;}
{ASSIGNOP} {yylval.a=newast("ASSIGNOP",0,yylineno);return ASSIGNOP;}
{RELOP} {yylval.a=newast("RELOP",0,yylineno);return RELOP;}
{PLUS} {yylval.a=newast("PLUS",0,yylineno);return PLUS;}
{MINUS} {yylval.a=newast("MINUS",0,yylineno);return MINUS;}
{STAR} {yylval.a=newast("STAR",0,yylineno);return STAR;}
{DIV} {yylval.a=newast("DIV",0,yylineno);return DIV;}
{AND} {yylval.a=newast("AND",0,yylineno);return AND;}
{OR} {yylval.a=newast("OR",0,yylineno);return OR;}
{DOT} {yylval.a=newast("DOT",0,yylineno);return DOT;}
{NOT} {yylval.a=newast("NOT",0,yylineno);return NOT;}
{TYPE} {yylval.a=newast("TYPE",0,yylineno);;return TYPE;}
{LP} {yylval.a=newast("LP",0,yylineno);return LP;}
{RP} {yylval.a=newast("RP",0,yylineno);return RP;}
{LB} {yylval.a=newast("LB",0,yylineno);return LB;}
{RB} {yylval.a=newast("RB",0,yylineno);return RB;}
{LC} {yylval.a=newast("LC",0,yylineno);return LC;}
{RC} {yylval.a=newast("RC",0,yylineno);return RC;}
{STRUCT} {yylval.a=newast("STRUCT",0,yylineno);return STRUCT;}
{RETURN} {yylval.a=newast("RETURN",0,yylineno);return RETURN;}
{IF} {yylval.a=newast("IF",0,yylineno);return IF;}
{ELSE} {yylval.a=newast("ELSE",0,yylineno);return ELSE;}
{WHILE} {yylval.a=newast("WHILE",0,yylineno);return WHILE;}
{ID} {yylval.a=newast("ID",0,yylineno);return ID;}
{SPACE} {printf(" ");}
{PERROR} {printf("Error type A at Line %d:Mysterious characters \'%s\'\n",yylineno,yytext);}
%%
int yywrap()
{
   return 1;
}