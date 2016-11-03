%{  
   #include "gramtree.h"
   #include "lex.yy.c"
%}

/*declared types*/
%union
{
   struct ast* a;
   double d;
}

/*declared tokens*/
%token <a> INT
%token <a> FLOAT
%token <a> INT_DEX INT_HEX INT_OCT ID SEMI COMMA
%token <a> ASSIGNOP RELOP PLUS MINUS STAR DIV AND 
%token <a> OR DOT NOT TYPE LP RP LB RB LC RC STRUCT
%token <a> RETURN IF ELSE WHILE SPACE EOL TRANS PERROR

%nonassoc LOWER_THAN_ELSE
%nonassoc ELSE

/*declared non-terminals*/
%type <a> Program ExtDefList ExtDef ExtDecList Specifier StructSpecifier 
%type <a> OptTag Tag VarDec FunDec VarList ParamDec CompSt StmtList 
%type <a> Stmt DefList Def DecList Dec Exp Args

/*priority*/
%right ASSIGNOP
%left OR
%left AND
%left RELOP
%left PLUS MINUS
%left STAR DIV
%right NOT 
%left DOT LP RP LB RB

%%
/*High-level Definnitions*/
Program : ExtDefList {$$=newast("Program",1,$1);printf("打印syntax tree:\n");eval($$,0);printf("syntax tree打印完毕!\n\n");}
;
ExtDefList : ExtDef ExtDefList {$$=newast("ExtDefList",2,$1,$2);}
  | {$$=newast("ExtDefList",0,-1);}
;
ExtDef : Specifier ExtDecList SEMI {$$=newast("ExtDef",3,$1,$2,$3);}
  | Specifier SEMI {$$=newast("ExtDef",2,$1,$2);}
  | Specifier FunDec CompSt {$$=newast("ExtDef",3,$1,$2,$3);}
;
ExtDecList : VarDec {$$=newast("ExtDecList",1,$1);}
  | VarDec COMMA ExtDecList {$$=newast("ExtDecList",3,$1,$2,$3);}
;

/*Specifiers*/
Specifier : TYPE {$$=newast("Specifier",1,$1);}
  | StructSpecifier {$$=newast("Specifier",1,$1);}
;
StructSpecifier : STRUCT OptTag LC DefList RC {$$=newast("StructSpecifier",5,$1,$2,$3,$4,$5);}
  | STRUCT Tag {$$=newast("StructSpecifier",2,$1,$2);}
;
OptTag : ID {$$=newast("OptTag",1,$1);}
  | {$$=newast("OptTag",0,-1);}
;
Tag : ID {$$=newast("Tag",1,$1);}
;

/*Declarators*/
VarDec : ID {$$=newast("VarDec",1,$1);}
  | VarDec LB INT RB {$$=newast("VarDec",4,$1,$2,$3,$4);}
;
FunDec : ID LP VarList RP {$$=newast("FunDec",4,$1,$2,$3,$4);}
  | ID LP RP {$$=newast("FunDec",3,$1,$2,$3);}
;
VarList : ParamDec COMMA VarList {$$=newast("VarList",3,$1,$2,$3);}
  | ParamDec {$$=newast("VarList",1,$1);}
;
ParamDec : Specifier VarDec {$$=newast("ParamDec",2,$1,$2);}
;

/*Statements*/
CompSt : LC DefList StmtList RC {$$=newast("CompSt",4,$1,$2,$3,$4);}
;
StmtList : Stmt StmtList {$$=newast("StmtList",2,$1,$2);}
  | {$$=newast("StmtList",0,-1);}
;
Stmt : Exp SEMI {$$=newast("Stmt",2,$1,$2);}
  | CompSt {$$=newast("Stmt",1,$1);}
  | RETURN Exp SEMI {$$=newast("Stmt",3,$1,$2,$3);}
  | IF LP Exp RP Stmt %prec LOWER_THAN_ELSE {$$=newast("Stmt",5,$1,$2,$3,$4,$5);}
  | IF LP Exp RP Stmt ELSE Stmt {$$=newast("Stmt",7,$1,$2,$3,$4,$5,$6,$7);}
  | WHILE LP Exp RP Stmt {$$=newast("Stmt",5,$1,$2,$3,$4,$5);}
;

/*Local Definitions*/
DefList : Def DefList {$$=newast("DefList",2,$1,$2);}
  | {$$=newast("DefList",0,-1);}
;
Def : Specifier DecList SEMI {$$=newast("Def",3,$1,$2,$3);}
;
DecList : Dec {$$=newast("DecList",1,$1);}
  | Dec COMMA DecList {$$=newast("DecList",3,$1,$2,$3);}
;
Dec : VarDec {$$=newast("Dec",1,$1);}
  | VarDec ASSIGNOP Exp {$$=newast("Dec",3,$1,$2,$3);}
;

/*Expressions*/
Exp : Exp ASSIGNOP Exp {$$=newast("Exp",3,$1,$2,$3);}
  | Exp AND Exp {$$=newast("Exp",3,$1,$2,$3);}
  | Exp OR Exp {$$=newast("Exp",3,$1,$2,$3);}
  | Exp RELOP Exp {$$=newast("Exp",3,$1,$2,$3);}
  | Exp PLUS Exp {$$=newast("Exp",3,$1,$2,$3);}
  | Exp MINUS Exp {$$=newast("Exp",3,$1,$2,$3);}
  | Exp STAR Exp {$$=newast("Exp",3,$1,$2,$3);}
  | Exp DIV Exp {$$=newast("Exp",3,$1,$2,$3);}
  | LP Exp RP {$$=newast("Exp",3,$1,$2,$3);}
  | MINUS Exp {$$=newast("Exp",2,$1,$2);}
  | NOT Exp {$$=newast("Exp",2,$1,$2);}
  | ID LP Args RP {$$=newast("Exp",4,$1,$2,$3,$4);}
  | ID LP RP {$$=newast("Exp",3,$1,$2,$3);}
  | Exp LB Exp RB {$$=newast("Exp",4,$1,$2,$3,$4);}
  | Exp DOT ID {$$=newast("Exp",3,$1,$2,$3);}
  | ID {$$=newast("Exp",1,$1);}
  | INT {$$=newast("Exp",1,$1);}
  | FLOAT {$$=newast("Exp",1,$1);}
;
Args : Exp COMMA Args {$$=newast("Args",3,$1,$2,$3);}
  | Exp {$$=newast("Args",1,$1);}
;
%%