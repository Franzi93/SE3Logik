binomial(_,0,1).

binomial(N,N,1).

binomial(N,K,Result):-
N1 is N-1,
K1 is K-1,
binomial(N1,K1,Result1),
binomial(N1,K,Result2),
Result is Result1+Result2.

/*Test
?- binomial(5,3,X).
X = 10 .
*/

/*
Die Funktion ist nicht endrekursiv, da Sie erst einen ganzen Baum an rekursiven Aufrufen aufbaut und dann von den Bl‰ttern aus die Aufrufe berechnet und anschlieﬂend erst zusammenfasst. */

%bonus
binomial_fak(N,K,Erg):-
fak(N,N1), 
fak(K, K1),
Nk is N-K, fak(Nk, NK1),
Erg is N1/(K1 * NK1) .

fak(1, 1).
fak(N, Erg):- 
N1 is N-1,
fak(N1, Zw),
Erg is Zw * N.

/*
?- binomial_fak(5,3,X).
X = 10 .
*/

%%% Folgendes ist falsch, Fehler wurde nicht gefunden
binomial_sum(N,K,Erg):-
binomial_sum(N,K,Erg,1).

binomial_sum(N,K,1,K).
binomial_sum(N,K,Erg,J):-
J1 is J+1,
Zw is (N+1-J)/J,
binomial_sum(N,K,Erg1,J1),
Erg is Erg1 * Zw.
/*
?- binomial_sum(5,3,X).
X = 7 .
*/
