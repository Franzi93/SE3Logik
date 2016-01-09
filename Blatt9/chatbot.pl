%rule(Pattern,Response).

rule([ich,habe,Menge,Art,gegessen,_],
[warum,hast,du,denn,so,wenige,Art,gegessen,’?’]) :-
    limit(Art,Limit),
    Menge =< Limit.

rule([ich,habe,Menge,Art,gegessen,_],
[warum,hast,du,denn,so,wahnsinnig,viele,Art,gegessen,’?’]) :-
    limit(Art,Limit),
    Menge > Limit.

rule([ich,will,X,_],
[ich,will,aber,viel,mehr,X,'!']).

limit(_,10).

/* Bei Ralf:
?- rule([ich,will,eiscreme,'.'],X).
X = [ich, will, aber, viel, mehr, eiscreme, !].

?- rule([ich,habe,3,elefanten,gegessen,'.'],X).
X = [warum, hast, du, denn, so, wenige, elefanten, gegessen, '’?’'] .

?- rule([ich,habe,17,gummibaerchen,gegessen,'.'],X).
X = [warum, hast, du, denn, so, wahnsinnig, viele, gummibaerchen, gegessen|...] .

Bei Franziska:

ERROR: c:/users/franziska/git/se3logik/blatt9/chatbot.pl:4:44: Syntax error: Operator expected
ERROR: c:/users/franziska/git/se3logik/blatt9/chatbot.pl:9:54: Syntax error: Operator expected
*/