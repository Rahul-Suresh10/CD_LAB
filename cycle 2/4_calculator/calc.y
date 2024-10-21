%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex();
%}

%token NUMBER ADD SUB MUL DIV LPAREN RPAREN

%% 

expression:
    expression ADD expression { printf("Result: %d\n", $1 + $3); }
    | expression SUB expression { printf("Result: %d\n", $1 - $3); }
    | expression MUL expression { printf("Result: %d\n", $1 * $3); }
    | expression DIV expression { 
        if ($3 == 0) {
            yyerror("Division by zero");
            exit(1);
        }
        printf("Result: %d\n", $1 / $3); 
      }
    | LPAREN expression RPAREN { $$ = $2; }
    | NUMBER { $$ = $1; }
    ;

%% 

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    printf("Enter an expression (Ctrl+D to exit): \n");
    while (yyparse() != 0); // Keep parsing until EOF
    return 0;
}

