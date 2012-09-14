CC=gcc
LD=ld
LEX=flex
YACC=yacc
CFLAGS=-c -Wall

all: gmon

gmon: y.tab.o lex.yy.o ssh2_exec.o loadfile.o
	$(CC) lex.yy.o y.tab.o ssh2_exec.o loadfile.o -o gmon -lssh2

lex.yy.o: lex.yy.c
	$(CC) -c lex.yy.c

y.tab.o: y.tab.c
	$(CC) -c y.tab.c

lex.yy.c: raid.l
	$(LEX) -i raid.l

y.tab.c: raid.y
	$(YACC) -d raid.y 

ssh2_exec.o: ssh2_exec.c
	$(CC) -c ssh2_exec.c

loadfile.o: loadfile.c
	$(CC) -c loadfile.c

clean:
	rm -rf *o gmon lex.yy.c y.tab.c y.tab.h
