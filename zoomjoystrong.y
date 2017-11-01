%{

#include "zoomjoystrong.h"
#include <stdio.h>
int yyerror(char * s);
%}

%union{
int Num;
float numFloat;
}


%token END_STATEMENT
%token END
%token POINT
%token LINE
%token CIRCLE
%token RECTANGLE
%token SET_COLOR
%token <Num> INT
%token <numFloat> FLOAT 



%%

program: statement_list 
;
statement_list: statement  statement_list
	      | statement
;
statement: point
	 | circle
	 | line
	 | rectangle
	 | set_color
	 | end
;
point:	 	POINT INT INT END_STATEMENT{

		if($2 < 0 | $2 > WIDTH | $3 > HEIGHT ){
		printf("Invalid point statement");
		}
		else{
		point($2, $3);
		}
}
;
line: 	 	LINE INT INT INT INT END_STATEMENT{

		if($2 < 0 | $2 > WIDTH | $3 > HEIGHT){
		printf("Invalid line statement");
		}
		else{
		line($2, $3, $4, $5);
		}
}
;
circle:	 	CIRCLE INT INT INT  END_STATEMENT{

		if($2 < 0 | $2 > WIDTH | $3 > HEIGHT){
		printf("Invalid circle statement");
		}
		else{
		circle($2, $3, $4);
		}
}
;
rectangle:	RECTANGLE INT INT INT INT END_STATEMENT{
		if($2 < 0 | $2 > WIDTH | $3 > HEIGHT){
		printf("Invalid rectangle statement");
		}
		else{
		rectangle($2, $3, $4, $5);
		}
}
;
set_color: SET_COLOR INT INT INT END_STATEMENT	{
		if($2 > 255 ||  $2 < 0 || $3 > 255 || $3 < 0 || $4 > 255 || $4 < 0){
		printf("Invalid set_color statement");
		}
		else{
		set_color($2, $3, $4);
		}
}
;

end: END END_STATEMENT{
	finish();
	exit(0);
}
;
	
%%
int main(int argc, char** argv){
	setup();
	yyparse();
	return 0;
}

int yyerror(char* s){
	printf("Error! %s\n", s);
	return 1;
}
