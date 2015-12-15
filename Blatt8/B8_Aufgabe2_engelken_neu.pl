%aus Skript Seite 125
trie2([[a, [b, [e, [n, [d, [*,abend]]]]],
[f, [f, [e, [*,affe]]]],
[l, [l, [e, [*,alle],
[s, [*,als]]]],
[s, [o, [*,also]]]]],
[b, [a, [u, [m, [*,baum]],
[e, [r, [*,aber]]]]]]] ).

%Aufgabe 2.1
%Wir werden einen orthografischen Schlüssel verwenden, daher wird das 1. Argument als Schlüssel benutzt.

%Aufgabe 2.2
% Fall 1 : Buchstabenbaum ist leer
trie([]).
% Fall 2 : Buchstabenbaum enthält Teilbäume
trie([H|T]) :-
    \+ \+ subtrie(H),
    trie(T).

% Teilbaum besteht aus Atom und Buchstabenbaum
subtrie([]).
subtrie([*|_]).
subtrie([H|T]):-
    atom(H),
    trie(T).

:- trie([]).
:- trie([[a,[*,info]]]).
:- trie([[a,[b,[*,info]],[c,[*,info]]]]).
:- \+ trie([a, [*,info]]).
:- \+ trie([a]).
:- \+ trie([a, [*,info]]).

%Aufgabe 2.3
%word2trie(+Liste, +Info, ?Baum)
word2trie(Liste, Info, [Baum]) :-
    word2trieInt(Liste, Info, Baum).

word2trieInt([], Info, [*,Info]).
word2trieInt([H|T], Info, [H,B2]) :-
    word2trieInt(T, Info, B2).

entry2trie(Entry, Trie) :-
    atom_chars(Entry, X),
    entry(Entry, Y),
    word2trie(X, Y, Trie).

%Aufgabe 2.4
%insert_entry(+Key, +Info, +OldT, ?NewT)

%Fall 1 : Liste mit Key ist bereits enthalten
%-Das erste Element (KeyH) des Keys wird extrahiert, der Rest des Keys ist KeyT
%-Die Liste mit KeyH als erstem Element wird aus dem alten Baum entfernt. Der Reduzierte alte Baum ist RedT, der Rest der entfernten Liste DelT.
%-insert_entry wird mit KeyT und DelT rekursiv aufgerufen und liefert ZwT als neuen Baum. Dabei wird DelT in eine Liste eingefügt, damit die Struktur erhalten bleibt
%-Ein neuer Teilbaum aus KeyH und ZwT wird erzeugt und RedT wieder angefügt. Da das Atom KeyH an erster Stelle stehen muß, ist diese Reihenfolge wichtig.
insert_entry(Key, Info, OldT, [NewT]) :-
    Key = [KeyH|KeyT],
    select([KeyH, DelT], OldT, RedT),
    append([KeyH], ZwT, ZwT2),
    append(ZwT2, RedT, NewT),
%    write_ln('--- Fall 1 ---'),
%    format('~w~10|~w~n',['Key:',Key]),
%    format('~w~10|~w~n',['OldT:',OldT]),
%    format('~w~10|~w~n',['RedT:',RedT]),
%    format('~w~10|~w~n',['ZwT:',ZwT]),
%    format('~w~10|~w~n',['ZwT2:',ZwT2]),
%    format('~w~10|~w~n',['NewT:',NewT]),
    insert_entry(KeyT, Info, [DelT], ZwT).

%Fall 2 : Liste mit Key ist noch nicht enthalten
%-Es wird ein Buchstabenbaum aus dem Key und der Info aufgebaut und an den übergebenen Baum angefügt.
insert_entry(Key, Info, OldT, NewT) :-
    Key = [KeyH|_],
    \+ select([KeyH,_], OldT, _),
    word2trie(Key, Info, ZwT),
%    write_ln('  --- Fall 2 ---'),
%    format('  ~w~10|~w~n',['Key:',Key]),
%    format('  ~w~10|~w~n',['OldT:',OldT]),
%    format('  ~w~10|~w~n',['ZwT:',ZwT]),
%    format('  ~w~10|~w~n',['NewT:',NewT]),
    append(OldT, ZwT, NewT).

%Fall 3 : Schlüssel ist abgearbeitet
%-Die Information wird an den Baum OldT angefügt.
insert_entry([], Info, OldT, NewT) :-
%    write_ln('    --- Fall 3 ---'),
%    format('    ~w~10|~w~n',['OldT:',OldT]),
%    format('    ~w~10|~w~n',['Info:',Info]),
%    format('    ~w~10|~w~n',['NewT:',NewT]),
    append(OldT, [[*,Info]], NewT).

% Fall 1
:- insert_entry([a], info, [[a,[s,[*,info]]]],              [[a,[s,[*,info]],[*,info]]]).
:- insert_entry([a], info, [[a,[s,[*,info]]],[q,[*,info]]], [[a,[s,[*,info]],[*,info],[q,[*,info]]]]).

% Fall 2
:- insert_entry([a],   info, [],             [[a,[*,info]]]).
:- insert_entry([a],   info, [[l,[*,info]]], [[l,[*,info]],[a,[*,info]]]).
:- insert_entry([a,l], info, [[l,[*,info]]], [[l,[*,info]],[a,[l,[*,info]]]]).

% Fall 3
:- insert_entry([], info, [],                          [[*, info]]).
:- insert_entry([], info, [[l,[*,info]]],              [[l,[*,info]],[*,info]]).
:- insert_entry([], info, [[l,[*,info]],[s,[*,info]]], [[l,[*,info]],[s,[*,info]],[*,info]]).

%Aufgabe 2.5
%dict2trie(?Tree)
dict2trie(Tree) :-
    dictionary(Dict),
    dict2trie(Dict, [], Tree).
    
dict2trie([], T, T).
dict2trie([DictH|DictT], OldT, NewT) :-
    dict2trie(DictT, OldT, ZwT),
    DictH = entry(Key, Value),
    atom_chars(Key, KeyAtom),
    insert_entry(KeyAtom, Value, ZwT, NewT).
%    write_ln(NewT).

%Aufgabe 2.6
%Anmerkung: Die Tests funktionieren nur mit einem relativ kleinen Ausschnitt aus dem Wörterbuch, ansonsten kommt es zu einem Stack-Überlauf.
% word2(?Word,+Trie,?Info).
word2([],[[*,Info]],Info).
word2([C|RW],[[C|RT]|_],Info) :- word2(RW,RT,Info).
word2(W,[_|Alt],Info) :- word2(W, Alt, Info).

/*
?- dict2trie(T),word2([z,w,a,r],T,I).
T = [[z, [w, [a, [*, [...|...]], [r|...]]], ['Z', [w, [e|...]], [z, [...|...]|...], [z|...]]]],
I = [ts, v, 'a:', r] .

?- dict2trie(T),word2(X,T,[ts, v, 'a:', r]).
T = [[z, [w, [a, [*, [...|...]], [r|...]]], ['Z', [w, [e|...]], [z, [...|...]|...], [z|...]]]],
X = [z, w, a, r] ;
*/
