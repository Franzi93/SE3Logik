%Ein einfacher Test-Bot, dem man mit say(--Satz in Liste--) 
%etwas erzählen kann und der dann antwortet 
%wurde mit member gemacht, dadurch ist er sehr flexibel

%say(+Pattern).

%begrüßung
say(P) :-
    (member(hallo, P);
	member(hi, P);
	member(guten, P),
	member(tag, P)),
	random_member(R,[[guten,tag,'!'],[hallo,'!'],[willkommen,.]]),
	list_to_sentence(R),
	!.
	
%spielerei
say(P) :-
    member(ahhhh, P),
	random_member(R,[[was,'?!'],[hallo,'?']]),
	list_to_sentence(R),
	!.
	
%ESSEN :)
say(P) :-
    (member(steak, P);
	member(raclette, P);
	member(wurst, P)),
	random_member(R,[[jetzt, habe, ich, hunger,.],[oh, wie, lecker,.]]),
	list_to_sentence(R),
	!.
%verabschiedung
say(P) :-
   (member(tschuess, P);
	member(bye, P);
	member(exit, P);
	member(bis, P),
	member(bald, P)),
	random_member(R,[[auf, wiedersehen,.],[bis, dann,.]]),
	list_to_sentence(R),
	halt.

%default satz, falls keine regel gilt
say(P) :-
	random_member(R,[[ich, weiss, nicht,vieles,.], [wie,bitte,'?']]),
	list_to_sentence(R).	
	
list_to_sentence([]).
list_to_sentence([H|RL]) :-
   write(H),
   write(' '),
   list_to_sentence(RL).
   
  /*
  1 ?- say([hallo, du]).
hallo ! 
true.

2 ?- say([ahhhh]).
hallo ? 
true.

3 ?- say([ein, steak, wäre, jetzt, toll]).
oh wie lecker . 
true.

4 ?- say([wohoo]).
ich weiss nicht vieles . 
true.

5 ?- say([echt, nicht,?]).
ich weiss nicht vieles . 
true.

6 ?- say([wieso,?]).
wie bitte ? 
true.
  */

