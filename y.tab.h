/* A Bison parser, made by GNU Bison 2.6.2.  */

/* Bison interface for Yacc-like parsers in C
   
      Copyright (C) 1984, 1989-1990, 2000-2012 Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_Y_TAB_H
# define YY_Y_TAB_H
/* Enabling traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     EOL = 258,
     NUMBER = 259,
     HELP = 260,
     SHOW = 261,
     ALL = 262,
     IP = 263,
     GOTO = 264,
     CREATE = 265,
     DELETE = 266,
     NODE = 267,
     FILENAME = 268,
     LOADKEY = 269,
     NODEDEFINE = 270,
     EQ = 271,
     NE = 272,
     LT = 273,
     LE = 274,
     GT = 275,
     GE = 276,
     PLUS = 277,
     MINUS = 278,
     MULT = 279,
     DIVIDE = 280,
     RPAREN = 281,
     LPAREN = 282,
     ASSIGN = 283,
     SEMICOLON = 284
   };
#endif
/* Tokens.  */
#define EOL 258
#define NUMBER 259
#define HELP 260
#define SHOW 261
#define ALL 262
#define IP 263
#define GOTO 264
#define CREATE 265
#define DELETE 266
#define NODE 267
#define FILENAME 268
#define LOADKEY 269
#define NODEDEFINE 270
#define EQ 271
#define NE 272
#define LT 273
#define LE 274
#define GT 275
#define GE 276
#define PLUS 277
#define MINUS 278
#define MULT 279
#define DIVIDE 280
#define RPAREN 281
#define LPAREN 282
#define ASSIGN 283
#define SEMICOLON 284



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;

#ifdef YYPARSE_PARAM
#if defined __STDC__ || defined __cplusplus
int yyparse (void *YYPARSE_PARAM);
#else
int yyparse ();
#endif
#else /* ! YYPARSE_PARAM */
#if defined __STDC__ || defined __cplusplus
int yyparse (void);
#else
int yyparse ();
#endif
#endif /* ! YYPARSE_PARAM */

#endif /* !YY_Y_TAB_H  */
