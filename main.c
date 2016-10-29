#include<stdio.h>
#include<stdlib.h>
int main(){
	extern FILE* yyin;
	if(!yyin = fopen("test.txt","r")){
		perror("test.txt");
		return 1;
	}
	while(yylex() != 0);
	return 0;
}