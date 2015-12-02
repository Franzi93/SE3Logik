%Aufgabe 2

%Aufgabe 2.1
%element_Leibnitz(N, Erg)
%Berechnet das N-te Element der Summe der Näherung für pi nach Leibnitz
element_Leibnitz(N, Erg) :-
    Erg is 4*((-1^(N+1))/(2*N-1)).

%pi_rec(N, Erg)
%Berechnet die Näherung für pi nach Leibnitz bis zur Tiefe N. N muß instanziiert werden.

pi_rec(0, 0).
pi_rec(N, Erg) :-
    element_Leibnitz(N, Element),
    N1 is N-1,
    pi_rec(N1, Zwischen),
    Erg is Zwischen + Element.

%Positiv-Tests:
%:- pi_rec(1, 4).


%pi_endrec(N, Erg)
%Berechnet Endrekursiv die Näherung für pi nach Leibnitz bis zur Tiefe N. N muß instanziiert werden.
pi_endrec(N, Erg) :-
    pi_endrec_int(N, 0, Erg).

pi_endrec_int(0, Erg, Erg).
pi_endrec_int(N, Zwischen, Erg) :-
    element_Leibnitz(N, Element),
    N1 is N-1,
    Zwischen1 is Zwischen + Element,
    pi_endrec_int(N1, Zwischen1, Erg).

%Positiv-Tests:
:- pi_endrec(1, 4).

%Aufgabe 2.2
/*
Die Endrekursive Version der Prädikate ist Verständlicher, da der Berechnungsvorgang leichter nachzuvollziehen ist. Pro Rekursiven Ablauf wird die aktuelle Leibnizzahl auf einen zusätzlichen Zwischenspeicher drauf gerechnet, danach kommt die Leibnizzahl-1, bis wir bei 0 sind und den Zwischenspeicher ausgeben können. Bei der anderen Version werden erst die einzelnen rekursiven Aufrufe durchgeführt und danach erst berechnet, was wesentlich schwerer durchschaubar ist.
*/

%Aufgabe 2.3
%element_wallis(N,Erg)
%Berechnet das N-te Element des Produktes der Näherung für pi nach Wallis
%    Erg is ((2*N)/(2*N - 1))*((2*N)/(2*N + 1)).
%ergibt vereinfacht:
element_wallis(N, Erg) :-
    Erg is (4*N**2)/(4*N**2 - 1).

%pi_wallis(N, Erg)
%Berechnet die Näherung für pi nach Leibnitz bis zur Tiefe N. N muß instanziiert werden.
pi_wallis(0, 2).
pi_wallis(N, Erg) :-
    element_wallis(N, Element),
    N1 is N-1,
    pi_wallis(N1, Zwischen),
    Erg is Zwischen * Element.

/*
Die Näherung nach Wallis konvergiert etwas schneller gegen pi als die von
Leibnitz. Außerdem ist pi obere Schranke der Wallis-Folge, wohingegen die Näherung nach Leibnitz
alternierend größer oder kleiner als pi ist, wie man gut durch Ausführen von pi_uebersicht/1 sehen kann
(pi ist obere Schranke der Teilfolge mit geraden N und untere Schranke der Teilfolge mitungeraden N).
*/
pi_uebersicht(0).
pi_uebersicht(N) :-
    pi_endrec(N, L),
    pi_wallis(N, W),
    Diff_L is L - 3.14159265358979323846,
    Diff_W is W - 3.14159265358979323846,
    N1 is N-1,
    pi_uebersicht(N1),
    ((1 is N mod 10) ->
        format('~` tN~4|~` tLeibnitz~22|~` tDiff. Leibnitz~40|~` tWallis~58|~` tDiff. Wallis~76|~n');write('')),
    format('~` t~d~4|~` t~12f~22|~` t~12f~40|~` t~12f~58|~` t~12f~76|~n', [N, L, Diff_L, W, Diff_W]).


%Aufgabe 3
%pi_incr(Grenze, Ergebnis)
%Gibt Pi inkrementell bis zur angegebenen Grenze nach Leibnitz berechnet aus
%Die Grenze muss übergeben werden
pi_incr(N, Erg) :- pi_incr(1, N, 0, Erg).

pi_incr(_,_,Erg,Erg) :- Erg>0. % Die Regel ist definiert um die Initialisierung abzufangen

pi_incr(Akku, N, Zw, Erg):-
	Akku =< N,
	element_Leibnitz(Akku, Erg2),
	Akku2 is Akku+1,
	Zw2 is Zw + Erg2,
	pi_incr(Akku2, N, Zw2, Erg).
/*
Test:
:- pi_incr(5, Erg).
Erg = 4 ;
Erg = 2.666666666666667 ;
Erg = 3.466666666666667 ;
Erg = 2.8952380952380956 ;
Erg = 3.3396825396825403 ;
false.
*/

/* 3.2
Nach ca. 40 Iterationen wird der Approximationsfehler durch die Display funktion kaum noch erkennbar ist, die Kurve ist nur noch einen Pixel von der roten Linie entfernt. Nach ca 110 Iterationen sieht man dann keinerlei Fehler mehr, die Kurve liegt quasi auf der Linie.
*/