CC=gcc
LD=ld
LEX=flex
YACC=yacc
CFLAGS=-c -Wall

all: ssh-kvr

ssh-kvr: y.tab.o lex.yy.o ssh2_exec.o
	$(CC) $^ -o $@ -lssh2

lex.yy.o: lex.yy.c
	$(CC) -c $<

y.tab.o: y.tab.c
	$(CC) -c $<

lex.yy.c: lex.l
	$(LEX) -i $<

y.tab.c: syntax.y
	$(YACC) -d $<

ssh2_exec.o: ssh2_exec.c
	$(CC) -c $<

clean:
	rm -rf *o ssh-kvr lex.yy.c y.tab.c y.tab.h
