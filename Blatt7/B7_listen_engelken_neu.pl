%Aufgabe 4.1
hamming_string(A, B, D) :-
    atom_chars(A, ListA),
    atom_chars(B, ListB),
    hamming_liste(ListA, ListB, D).

hamming_liste([], [], 0).
hamming_liste([H1|T1], [H2|T2], D) :-
    H1 = H2,
    hamming_liste(T1, T2, D).
hamming_liste([H1|T1], [H2|T2], D) :-
    \+ H1 = H2,
    hamming_liste(T1, T2, D1),
    D is D1 + 1.

%Positiv-Tests:
:- hamming_liste([],[],0).
:- hamming_liste([a,b],[a,b],0).
:- hamming_liste([a,b],[a,c],1).
:- hamming_liste([a,b],[b,c],2).

%Negativ-Tests:
:- \+ hamming_liste([a,b],[a,b,c],_).

%Aufgabe 4.2
hamming_liste([], [_|T], D) :-
    hamming_liste([], T, D1),
    D is D1 + 1.
hamming_liste([_|T], [], D) :-
    hamming_liste(T, [], D1),
    D is D1 + 1.

%Positiv-Tests:
:- hamming_liste([a,b],[a,b,c],1).
:- hamming_liste([a,b,c],[a,b],1).
:- hamming_liste([a,b],[a,c,b],2).

%Aufgabe 4.3
hamming_liste_erw([], [], 0, []).
hamming_liste_erw([H1|T1], [H2|T2], D, [[H1, H2]|L]) :-
    H1 = H2,
    hamming_liste_erw(T1, T2, D, L).
hamming_liste_erw([H1|T1], [H2|T2], D, [[H1, H2]|L]) :-
    \+ H1 = H2,
    hamming_liste_erw(T1, T2, D1, L),
    D is D1 + 1.

hamming_liste_erw([], [H|T], D, [[*, H]|L]) :-
    hamming_liste_erw([], T, D1, L),
    D is D1 + 1.
hamming_liste_erw([H|T], [], D, [[H, *]|L]) :-
    hamming_liste_erw(T, [], D1, L),
    D is D1 + 1.

%Positiv-Tests:
:- hamming_liste_erw([a,b],[a,b],0,[[a,a],[b,b]]).
:- hamming_liste_erw([a,b],[a,b,c],1,[[a,a],[b,b],[*,c]]).
:- hamming_liste_erw([a,b],[a,c,b],2,[[a,a],[b,c],[*,b]]).

%Aufgabe 4.4
alignment(L1, L2, D, _) :-
    length(L1, X1),
    length(L2, X2),
    X1 = X2,
    hamming_liste(L1, L2, D).
alignment(L1, L2, D, I) :-
    length(L1, X1),
    length(L2, X2),
    X1 < X2,
    nth0(I, L1Neu, *, L1),
    alignment(L1Neu, L2, D, I).
alignment(L1, L2, D, I) :-
    length(L1, X1),
    length(L2, X2),
    X1 > X2,
    nth0(I, L2Neu, *, L2),
    alignment(L1, L2Neu, D, I).

%Positiv-Tests
:- alignment([a,b],[],2,0).
:- alignment([a,b,c,d],[a,d],3,0).
:- alignment([a,b,c,d],[a,d],2,1).
:- alignment([a,b,c,d],[a,d],3,2).

% levenshtein(+Liste1,+Liste2,?Levenshtein_Distanz)
levenstein(L1,L2,LDistanz) :-
    findall(Distanz,alignment(L1,L2,Distanz,_),Distanzen),
    min_list(Distanzen,LDistanz).

:- levenstein([],[a,d],2).
:- levenstein([a,b,c,d],[a,d],2).

%Aufgabe 4.5
%Die Distanz kann nicht kleiner werden als der Längenunterschied beider Listen.
%Findet man eine Einfügeposition, an der die Distanz dem Längenunterschied entspricht,
%kann die Suche abgebrochen werden. Man kann die Suche rekursiv durchführen und einen entsprechenden Rekursionsabbruch implementieren.