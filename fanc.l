%{
	#include<stdio.h>
	#include<stdlib.h>
%}

DEC [1-9][0-9]*|[0]
OCT 0[1-7][0-7]*
HEX 0[Xx]([1-9a-fA-F][0-9a-fA-F]+|[1-9a-fA-F])
INT [+]?{DEC}|{OCT}|{HEX}
EXP [0-9]*[.]([0-9]*)?[Ee][+-]?[0-9]*f?
FLOAT [0-9]+[.][0-9]+
LETTER [a-z|A-Z]
SEMI \;
COMMA \,
EQUAL \=
RELOP >|<|>=|<=|==|!=
PLUS \+
MINUS \-
STAR \*
DIV \/
AND &&
OR \|\|
NOT \!
LP \(
RP \)
LB \[
RB \]
LC \{
RC \}
STRUCT struct
IF if
ELSE else
WHILE while 
ID [a-zA-Z_][a-zA-Z_0-9]*
CL [\n]
SPACE ([ ]*)|[\t]
COMMENT1 \/\/[^\n]*
COMMENT2 \/\*([^\*^\/]*|[\*^\/*]*|[^\**\/]*)*\*\/


%%
{DEC}   {printf("DEC\t");}
{OCT}	{printf("OCT\t");}
{HEX}	{printf("HEX\t");}
{INT}   {printf("INT\t");}
{EXP}   {printf("EXP\t");}
{FLOAT} {printf("FLOAT\t");}
{LETTER} {printf("LETTER\t");}
{SEMI}  {printf("SEMI\t");}
{COMMA} {printf("COMMA\t");}
{EQUAL} {printf("EQUAL\t");}
{RELOP} {printf("RELOP\t");}
{PLUS}  {printf("PLUS\t");}
{MINUS} {printf("MINUS\t");}
{STAR}  {printf("STAR\t");}
{DIV}   {printf("DIV\t");}
{AND}   {printf("AND\t");}
{OR}    {printf("OR\t");}
{NOT}   {printf("NOT\t");}
{LP}    {printf("LP\t");}
{RP}    {printf("RP\t");}
{LB}    {printf("LB\t");}
{RB}    {printf("RB\t");}
{LC}    {printf("LC\t");}
{RC}    {printf("RC\t");}
{STRUCT}   {printf("STRUCT\t");}
{IF}   {printf("IF\t");}
{ELSE}   {printf("ELSE\t");}
{WHILE}   {printf("WHILE\t");}
{ID}    {printf("ID\t");}
{CL} {printf("\n");}
{SPACE} {printf("");}
{COMMENT1}   {printf("COMMENT1\t");}
{COMMENT2}   {printf("COMMENT2\t");}
%%

int yywrap() {
  return 1;
}

int main(int argc, char** argv) 
{
   if (argc > 1) 
   {
       if (!(yyin = fopen(argv[1], "r"))) 
       {   
           perror(argv[1]);
           return 1;
       }
   }
   while (yylex());
   return 0;
}
