%rule(Pattern,Response).
limit(steaks,5).

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

