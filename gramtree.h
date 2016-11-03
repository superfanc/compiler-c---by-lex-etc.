#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>//变长参数函数所需的头文件
#include <unistd.h>
extern int yylineno;//行号
extern char * yytext;//词
void yyerror(char *s , ...);//错误处理函数

/*抽象语法树的节点*/
struct ast
{
	int line; //行号
	char * name; //语法单元的名字
	struct ast * l;  //left children
	struct ast * r;  //right children
	union {      //save ID TYPE INTEGER FLOAT
		char * idtype;
		int intgr;
		float flt;;
	};
};
/*构造抽象语法树，变长参数，name:语法单元名字；num:变长参数中语法节点的个数*/
struct ast *newast(char * name , int num , ...);

/*遍历抽象语法树，level为树的层数*/
void eval(struct ast * , int level);