%Zerlegen einer Liste
% split(+Liste,+MittleresElement,?VordereElemente,?HintereElemente)
split([ ],_,[ ],[ ]).
split([E|R],M,[E|VL],HL) :-
E@=<M, split(R,M,VL,HL).
split([E|R],M,VL,[E|HL]) :-
E@>M, split(R,M,VL,HL).

%Umwandeln einer Liste in einen sortierten Baum und Rückumwandeln in eine (sortierte) Liste
% sort_t(+Liste,?SortierteListe)
sort_t(L,SL) :-
list2tree(L,B),
tree2list(B,SL).

% tree2list(+Baum,?Liste)
tree2list(end,[ ]).
tree2list(t(E,VB,HB),L) :-
tree2list(VB,VL),
tree2list(HB,HL),
append(VL,[E|HL],L).

%Umwandeln der Liste in einen Baum
% list2tree(+Liste,?Baum)
list2tree([ ],end).
list2tree([E|R],t(E,VB,HB)) :-
    split(R,E,VL,HL),
    list2tree(VL,VB),
    list2tree(HL,HB).

%?- list2tree([d,c,a,e,b],B).
%B = t(d, t(c, t(a, end, t(b, end, end)),
%end), t(e, end, end)).

%Umwandeln der Liste beim rekursiven Aufstieg
% list2tree(+Liste,?Baum)
list2tree([E],t(E,end,end)).
list2tree([E|R],t(S,VB,HB)) :-
    list2tree(R,t(S1,VB1,HB1)),
    intree(E,t(S1,VB1,HB1),t(S,VB,HB)).

%?- list2tree([d,c,a,e,b],B).
%B = t(b, t(a, end, end), t(e, t(c, end,
%t(d, end, end)), end)).

%Einfügen eines Elementes in einen (sortierten) Baum
% intree(+Element,+BaumAlt,?BaumNeu)
intree(E,end,t(E,end,end)).
intree(E,t(S,VB,HB),t(S,VBN,HB)) :-
E@=<S, intree(E,VB,VBN).
intree(E,t(S,VB,HB),t(S,VB,HBN)) :-
E@>S, intree(E,HB,HBN).

%Aufgabe 2

/*
Aufgabe 2.1
Der Baum wird so aufgebaut, daß das erste Element E1 der Liste zur Wurzel wird, und der Rest
der Liste in 2 Teillisten mit kleineren|gleichen bzw. größeren Elementen aufgeteilt wird.
Die Teillisten werden dabei nicht sortiert,die Reihenfolge der Elemente bleibt erhalten.
Aus beiden Teillisten werden wieder Bäume erstellt, deren Wurzeln Blätter von E1 werden.

Wenn der Baum aus einer sortierten Liste erstellt wird, bleibt immer ein Blatt leer und man erhält erneut eine Liste

Um einen balancierten Baum zu erhalten,muß die Liste so sortiert sein, daß in jedem Schritt das
erste Element der (Teil-)Liste dem Median aller Elemente entspricht. Das führt dazu, daß immer beide
Äste gleich viele Elemente (+- 1) enthalten und somit der Baum balanciert ist.
Beispiel: 5,3,1,4,2,7,9,8,6
->
               5
            /     \
          3         7
        /   \     /   \
       1     4   6     9
        \             /
         2           8
*/

%Aufgabe 2.2
%Als Repräsentation wird statt des Elements eine Liste verwendet, deren Kopf das Element ist.
%E -> [E,Info]

%Aufgabe 2.3
set_info(t([Knoten,InfoAlt], _, _), Knoten, Info) :-
    InfoAlt = Info.
set_info(t(_, VB, HB)   , Knoten, Info) :-
    set_info(VB, Knoten, Info);
    set_info(HB, Knoten, Info).

get_info(t([Knoten,Info], _, _), Knoten, Info).
get_info(t(_, VB, HB)   , Knoten, Info) :-
    get_info(VB, Knoten, Info);
    get_info(HB, Knoten, Info).

:- get_info(t([1,erster],t([2,zweiter],end,end),t([3,dritter],end,end)), 2, zweiter).
/+ :- get_info(t([1,erster],t([2,zweiter],end,end),t([3,dritter],end,end)), 4, _).

%Aufgabe 2.4
% Es wird eine Unterfunktion aufgerufen, damit die Liste nur einmal sortiert werden muß.
% Da delete alle Einträge des übergebenen Elements aus der Liste löscht, werden nur dann
% korrekte Ergebnisse ausgegeben, wenn jedes Element nur einmal in der Liste vorkommt.
% list2balanced_tree(+Liste,?Baum)
list2balanced_tree(Liste,Baum):-
    sort_t(Liste, ListeSort),
    sortedList2balanced_tree(ListeSort,Baum).

sortedList2balanced_tree([],end).
sortedList2balanced_tree([Head|[]],t(Head, end, end)).
sortedList2balanced_tree([Head|X],t(Head, t(X, end, end), end)) :-
    length(X,1),
    x@=<Head.
sortedList2balanced_tree([Head|X],t(Head, end, t(X, end, end))) :-
    length(X,1),
    x@>Head.
sortedList2balanced_tree(Liste, t(Element, VB, HB)) :-
    length(Liste, Length),
    Length > 1,
    round((Length-1) / 2, Position),
    nth0(Position, Liste, Element),
    split(Liste, Element, VL, HL),
    delete(VL, Element, VL2),
    sortedList2balanced_tree(VL2, VB),
    sortedList2balanced_tree(HL, HB).

:- list2balanced_tree([], end).
:- list2balanced_tree([a], t(a, end, end)).
:- list2balanced_tree([a,b,c], t(b, t(a, end, end), t(c, end, end))).
:- list2balanced_tree([a,b,c,d,e,f,g], t(d, t(b, t(a, end, end), t(c, end, end)), t(f, t(e, end, end), t(g, end, end)))).
