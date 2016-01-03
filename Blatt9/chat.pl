%rule(Pattern, Response).

rule([ich,habe,Menge,Art,gegessen],
[warum,hast,du,Menge,Art,gegessen,'?']):-
Menge >= 10.

