
%Aufgabe1.1
coins([200,100,50,20,10,5,2,1]).

%change(Coins, Change)
change(0,[]).
change(Coins,[C|RL]):-
	coins(C1),
	member(C,C1),
	C =< Coins,
	Coins1 is Coins - C,
	change(Coins1,RL).
	
/*
8 ?- change(5,X).
X = [5] ;
X = [2, 2, 1] ;
X = [2, 1, 2] ;
X = [2, 1, 1, 1] ;
X = [1, 2, 2] ;
X = [1, 2, 1, 1] ;
X = [1, 1, 2, 1] ;
X = [1, 1, 1, 2] ;
X = [1, 1, 1, 1, 1] ;

 ?- change(0,X).
X = [] .
*/
	
%Aufgabe1.2	
change_sort(Coins,Change):-
change(Coins,Change),
sortiere(Change).

%sortiere(List)
sortiere([H| []]).
sortiere([H, F|RL]) :- 
H @>= F, 
sortiere([F|RL]).

/*
?- change_sort(5,X).
X = [5] ;
X = [2, 2, 1] ;
X = [2, 1, 1, 1] ;
X = [1, 1, 1, 1, 1] ;
*/
%Aufgabe1.3
change_min(Coins, Change):-
change_sort(Coins, Change),
!.
/*
9 ?- change_min(5,X).
X = [5].
*/

%Aufgabe1.4
/*

*/

%Aufgabe1.5

:- dynamic automat/1.
automat([200-3, 100-3, 50-3,  20-3, 10-3, 5-3, 2-3, 1-3]).
 
% get_coinnumber(+Coin, ?Number)
get_coinnumber(Coin, Number) :-
    automat(L),
    list_to_assoc(L, Assoc),
    get_assoc(Coin, Assoc, Number).
	
%set_coinnumber(+Coin, ?Number)
set_coinnumber(Coin, Number):-
	automat(L),
	list_to_assoc(L,Assoc),
	get_assoc(Coin, Assoc, _, Assoc1, Number),
	assoc_to_list(Assoc1, L1),
	retractall(automat(_)),
	assert(automat(L1)).
	
%take_money(+Coinlist)
take_money([]).	
take_money([H|RL]):-
	change_possible([H|RL]),
	get_coinnumber(H, T0),
	T1 is T0 - 1,
	set_coinnumber(H, T1),
	take_money(RL).
	
%add_money(+Coinlist)
add_money([]).	
add_money([H|RL]):-
	get_coinnumber(H, T0),
	T1 is T0 + 1,
	set_coinnumber(H, T1),
	add_money(RL).
	
%count(+Member,+List,?Number)
count(_, [], 0).
count(X, [X | T], N) :-
  !, count(X, T, N1),
  N is N1 + 1.
count(X, [_ | T], N) :-
  count(X, T, N).
	
%change_possible(+Coinlist)
change_possible([]).
change_possible([H|RL]):-
	count(H,[H|RL], A),
	get_coinnumber(H,B),
	A =< B,
	change_possible(RL).

%possible_changes(+Coins, ?Change)
possible_changes(Coins, Change):-
	change(Coins, Change),
	sortiere(Change),
	change_possible(Change).

%pay(+Preis,+Coinlist,?Changes)
pay(Price, MoneyL, Changes):-
	sum_list(MoneyL,Money),
	Price =< Money,
	change_min(Price,Add),
	add_money(Add),
	Change is Money - Price,
	possible_changes(Change, Changes).
/*
?- automat(G).
G = [200-3, 100-3, 50-3, 20-3, 10-3, 5-3, 2-3, 1-3].

2 ?- add_money([2,5,10]).
true.

3 ?- automat(G).
G = [1-3, 2-4, 5-4, 10-4, 20-3, 50-3, 100-3, 200-3]. %%Geld hinzugefügt

4 ?- take_money([1,10]).
true .

5 ?- automat(G).
G = [1-2, 2-4, 5-4, 10-3, 20-3, 50-3, 100-3, 200-3]. %%Geld genommen

6 ?- take_money([1,1,1]).
false.

7 ?- automat(G).
G = [1-2, 2-4, 5-4, 10-3, 20-3, 50-3, 100-3, 200-3]. %%keine Änderungen

8 ?- possible_changes(5,X).
X = [5] ;
X = [2, 2, 1] ;
false.

9 ?- pay(45,[50],X).
X = [5] ;
X = [2, 2, 1] ;
false.

?- automat(G).
G = [1-2, 2-4, 5-5, 10-3, 20-5, 50-3, 100-3, 200-3]. %%es wurden 2x20 und 1x5 eingezahlt

?- pay(45,[5],X).
false.

?- automat(G).
G = [1-2, 2-4, 5-5, 10-3, 20-5, 50-3, 100-3, 200-3]. %%keine Änderungen
*/