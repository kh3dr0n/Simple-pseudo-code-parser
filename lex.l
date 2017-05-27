%option noyywrap
%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "parser.h"

%}

%%

 /* affectation */
"<-"      { return OP_ASSIGN;  }

 /* math  */
"+"      { return OP_ADD;     }
"-"      { return OP_SUB;     }
"*"      { return OP_MUL;     }
"/"      { return OP_DIV;     }

 /* comparison  */
">"      { return OP_GT;      }
"<"      { return OP_LT;      }
"=="     { return OP_EQ;      }
"!="     { return OP_NE;      }
"<="     { return OP_LE;      }
">="     { return OP_GE;      }



 /* terminaison */
";"      { return SEMICOLON;  }
","      { return COMMA;  }


 /* strucutre */
"{"      { return LBRACE;     }
"}"      { return RBRACE;     }
"("      { return LPAREN;     }
")"      { return RPAREN;     }

"["		{ return LBRACKETS; }
"]"		{ return RBRACKETS; }

 /* type  */
"entier"    { return KW_INT;     }
"reel"  { return KW_REEL;   }
"booleen"  { return KW_BLN;   }

 /* logique op */
"et" { return OP_ET; }
"ou" { return OP_OU; }



 /* Entier et reel */
[0-9]+ { return INT_CONSTANT; }
[0-9]+\.[0-9]+ { return FLOAT_CONSTANT; }


 /* Si alor sinon finsi  */
"si"     { return KW_SI;      }
"alors"   { return KW_ALORS;    }
"sinon"  { return KW_SINON;   }
"finsi"  { return KW_FINSI;   }


 /* Pour  */
"pour"     { return KW_POUR;      }
"finpour"   { return KW_FINPOUR;    }
"de"  { return KW_DE;   }
"faire"  { return KW_FAIRE;   }


"debut" { return KW_DEBUT; }
"fin" { return KW_FIN; }

"algorithme" { return KW_ALGO; }


"lire" { return KW_LIRE; }
"afficher" { return KW_AFFICHER; }

 /* Id */
[a-zA-Z][a-zA-Z0-9]* { return IDENTIFIER; }

 /*  chaine ""  */
\"([^\\\"]|\\.)*\" { return STR; }

 /* whitespace */
[ \r\t]+ { }

 /* newlines */
\n { }

 /* characters */
.  {  }

%%