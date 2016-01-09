/*
Aufgabenblatt 9
Bearbeitet von :
Christopher Biegel(6312199),
Marco Lengua(6094351),
Oliver Vietor(6334524).
*/


% Aufgabe 1: Chatbotti der Chatbot !


/*
Bedienungsanleitung:
1. Programm starten: 'main.'  eingeben (main/0 aufrufen)
2a. Satz schreiben (muss mit einem Satzzeichen [?,.,!] enden) und
   mit Enter abschicken.
3. Nach der Chatbot-Antwort einmal Enter druecken.
4. goto 2.
2b. Programm beenden: 'quit.'  eingeben

--------------------------------------------

Beispiel-Dialog:
# U = Usereingaben
# B = Antwort von Chatbotti

U: hallo.
B: hey, wie geht es dir?

U: mir geht es hervorragend.
B: mir geht es heute auch hervorragend. wie heisst du eigentlich?

U: mein name ist waldemar.
B: waldemar ist ein schoener name. ich heisse chatbotti.

U: hast du schoene urlaubstage gehabt?
B: ja, ich habe schoene urlaubstage gehabt.

U: ich habe 300 kekse gegessen.
B: warum hast du sooo viele kekse gegessen?

U: ich mag kekse.
B: das kann ich verstehen. kekse sind auch toll.

U: warum findest du kekse denn toll?
B: das weiss ich auch nicht.

U: warum ist die banane krumm?
B: warum nicht?

U: was ist die antwort zum leben dem universum und dem ganzen rest?
B: 42.

U: wie findest du Fussball?
B: fussball finde ich total toll!

U: wie findest du das internet?
B: * gaehn *

U: wo ist hamburg?
B: hamburg ist ganz in meiner naehe!

U: wo gibt es leckeres essen?
B: sehe ich aus wie eine karte?

U: tut mir leid.
B: entschuldigung angenommen.

U: was machen wir jetzt?
B: entschuldigung ich habe gerade nicht aufgepasst.

U: toll.
B: was findest du toll?

U: chatbotti!
B: was ist denn nun schon wieder?

U: ich mag dich!
B: danke. ich finde dich allerdings etwas nervig.

U: auf wiedersehen.
B: adios, war schoen mit dir zu sprechen.
*/


% Verschiedene Woerter-Listen:
% Werden benutzt, um entweder bestimmte Muster zu erkennen
% (z.B. Begruessungen, Zustaende, etc.) oder um zufaellige
% Antworten wiederzugeben.
begruessungen([hallo,hey,hi,moin]).

zustaende([gut,schlecht,mittelmaessig,toll,fantastisch,grausam,hervorragend]).

verbListe([will,moechte,darf,muss]).

verabschiedungen([[auf,wiedersehen],bye,tschuess,adios,[machs,gut]]).

warum_antworten([[warum,nicht,'?'],[das,weiss,ich,auch,nicht,'.'],
		 [da,bin,ich,ueberfragt,'.']]).

meinungs_antworten([[ist,nicht,mein,ding,'.'],[das,ist,doch,bloed,'!'],
		   [das,ist,total,klasse,'!'],['*',gaehn,'*'],
		   [super,toll,'!']]).

wo_antworten([[sehe,ich,aus,wie,eine,karte,'?'],
	      [wahrscheinlich,zwischen,europa,und,asien,'.'],
	      [vielleicht,bei,dir,zu,hause,'?'],
	      [sicherlich,ganz,in,der,naehe,'.']]).

entschuldigungen([entschuldigung,[tut,mir,leid],sorry,[war,nicht,so,gemeint]]).

common_antworten([[lass,uns,ueber,etwas,anderes,sprechen,'.'],
		  [ich,habe,dich,nicht,verstanden,'.'],
		  [koenntest,du,das,bitte,wiederholen,'?'],
		  [entschuldigung,ich,habe,gerade,nicht,aufgepasst,'.'],
		  [wie,bitte,'?']]).



% rule(+Pattern,-Response).
% Simuliert das Pattern-Response-Verhalten. Zu einem bestimmten Pattern
% gibt es eine (oder mehrere) Response(s).

rule([BegruessungE|_], [BegruessungR,',',wie,geht,es,dir,'?']) :-
	begruessungen(Begr),
	member(BegruessungE, Begr),
	random_antwort(BegruessungE, Begr, BegruessungR).

rule([mir,geht,es,Zustand,_],
     [mir,geht,es,heute,auch,Zustand,'.',wie,heisst,du,eigentlich,'?']) :-
	zustaende(Zust),
	member(Zustand, Zust).

rule(NamensBekanntgabe,
     [Name,ist,ein,schoener,name,'.',ich,heisse,chatbotti,'.']):-
	member(NamensBekanntgabe, [[mein,name,ist,Name,_], [ich,heisse,Name,_]]).

rule([hast, du|R],
    [ja,',',ich,habe,Out,'.']):-
	ignoriere_satzzeichen(R,Out).

rule([ich,Verb,Begriff,_],   [warum,VerbAntwort,du,Begriff,'?']) :-
	verbListe(Verben),
	member(Verb, Verben),
	atom_concat(Verb,st,VerbAntwort).

rule([chatbotti,_],
     [was,ist,denn,nun,schon,wieder,'?']).

rule([ich, habe,Menge,Art,gegessen,_],
[warum,hast,du,sooo,viele,Art,gegessen,'?']) :-
	integer(Menge),
	Menge > 20.

rule([ich, habe,Menge,Art,gegessen,_],
[warum,hast,du,Menge,Art,gegessen,'?']) :-
	integer(Menge),
	Menge =< 20.

rule([ich, habe,Art,gegessen,_],
[warum,hast,du,Art,gegessen,'?']).

rule([ich, mag, dich, _],
     [danke,'.',ich,finde,dich,allerdings,etwas,nervig,'.']).

rule([ich, mag, Art,_],
     [das, kann, ich, verstehen, '.', Art, sind, auch, toll,'.']).

rule([warum,ZweitesWort|_],
     WarumAntwort):-
	warum_antworten(MoeglicheAntworten),
	random_antwort(ZweitesWort,MoeglicheAntworten,WarumAntwort).


rule([wer,ist,Name,_],
     [ich,weiss,nicht,wer,Name,ist,'.']).

rule([was,ist,Name,_],
     [Name,ist,bestimmt,wichtig,'.']).

rule([wie,findest,du,X,_],
     [X,finde,ich,total,toll,'!']).

rule([wie,findest,du,Next|_],
     MeinungsAntwort):-
	meinungs_antworten(MoeglicheAntworten),
	random_antwort(Next,MoeglicheAntworten,MeinungsAntwort).

rule([wo,ist,X,_],
     [X,ist,ganz,in,meiner,naehe,'!']).

rule([wo,Next|_],
     WoAntwort):-
	wo_antworten(MoeglicheAntworten),
	random_antwort(Next,MoeglicheAntworten,WoAntwort).

rule([Entschuldigung|_], [entschuldigung,angenommen,'.']):-
	entschuldigungen(Liste),
	member(Entschuldigung,Liste).

rule(Entschuldigung, [entschuldigung,angenommen,'.']):-
	entschuldigungen(Liste),
	ignoriere_satzzeichen(Entschuldigung, Out),
	member(Out,Liste).

rule(Eingabe, ['42','.']):-
	member(leben, Eingabe),
	member(universum, Eingabe),
	member(rest, Eingabe).

rule([Zustand,_], [was,findest,du,Zustand,'?']):-
	zustaende(Zustaende),
	member(Zustand, Zustaende).

rule([VerabschiedungE|_], [VerabschiedungR,',',war,schoen,mit,dir,zu,sprechen,'.']) :-
	verabschiedungen(Verabsch),
	member(VerabschiedungE, Verabsch),
	random_antwort(VerabschiedungE, Verabsch, VerabschiedungR).

rule(VerabschiedungE, [VerabschiedungR,',',war,schoen,mit,dir,zu,sprechen,'.']) :-
	verabschiedungen(Verabsch),
	ignoriere_satzzeichen(VerabschiedungE, Out),
	member(Out, Verabsch),
	first(VerabschiedungE, ErstesWort),
	random_antwort(ErstesWort, Verabsch, VerabschiedungR).


% Abschlussnachricht nachdem quit eingegeben wurde.
rule([quit,_], [byebye]).

% Chatbot hat keine passende Regel gefunden und gibt deshalb eine
% Standardantwort zurueck.
rule([ErstesWort|_], CommonAntwort):-
	common_antworten(MoeglicheAntworten),
	random_antwort(ErstesWort,MoeglicheAntworten,CommonAntwort).



% main/0.
% Startet den Chatbot.
% Der Chatbot laesst sich mit der Eingabe von 'quit.' beenden.
main:-
	repeat,
	read_sentence(Words),
	input(Words, Ausgabe),
	schreibeAntwort(Ausgabe),
	istSchluss(Words).


% input(+Eingabe, -Ausgabe).
% Sucht in der Datenbasis nach einer passenden Antwort zur Eingabe.
% Es wird nur die erste passende Antwort ausgegeben.
input(Eingabesatz, Ausgabe):-
	rule(Eingabesatz, Ausgabe),!.


% schreibeAntwort(+Liste).
% Wandelt die List von Woertern in einen Satz um.

% entweder ist der Input ein Element aus der Liste (ein einzelnes Wort):
schreibeAntwort(List):-
	member(X, List),
	atom(X),
	write(X), write(' ').

% oder er ist eine eigene Liste (ein Satz(-fragment)):
schreibeAntwort(List):-
	member(X, List),
	member(Y, X),
	write(Y), write(' ').


% istSchluss(+Eingabe).
% Prueft, ob der Benutzer "quit" eingegeben hat.
istSchluss(Eingabe) :- member(quit,Eingabe).




% ################### ab hier Hilfspraedikate #################

% random_antwort(+ErstesWortDerEingabe, +AlleAntwortMoeglichkeiten,
%                 -ZufaelligeAntwort).
%
% Es wird eine (fast) zufaellige Antwort ausgegeben: Die Anzahl der
% Buchstaben des 1. Wortes der Benutzereingabe bestimmen den Index der
% Antwort.
random_antwort(ErstesWort, AlleAntworten, ZufaelligeAntwort) :-
	atom_length(ErstesWort, LaengeErstesWort),
	length(AlleAntworten, LaengeAntworten),
	Index is (LaengeErstesWort mod LaengeAntworten) + 1,
	gebi(AlleAntworten,Index,ZufaelligeAntwort).

% Beispiel-Aufruf:
% random_antwort([tschuess,'!'],
%     [[auf,wiedersehen],tschuess, bye, ciao], Antwort).
% Antwort = [auf, wiedersehen].


% gebi(+Liste,+Index,-ElementBeiIndex).
% get list-element by index
% Quelle: http://www.tnotes.de/PrologListen
% Zugriff auf Element mit Index N, startend bei 1
%
% der Cut unterdrueckt, dass nachdem die Rekursion abgeschlossen wurde,
% noch einmal in die 2. Regel gegangen wird (und als weitere Antwort
% alternative false mit ausgegeben wird)
gebi([K|_],1,K) :- !.
gebi([_|R],N,E):- M is N-1, gebi(R,M,E).


% ignoriere_satzzeichen(+Eingabeliste, -Ausgabeliste).
% Gibt die Eingabeliste als Ausgabeliste wieder, mit der Eigenschaft,
% dass die Ausgabeliste das letzte Element nicht beinhaltet.
ignoriere_satzzeichen([_],[]).
ignoriere_satzzeichen([X|R],[X|R2]) :-
  ignoriere_satzzeichen(R,R2).


% first(+Liste, -Element).
% Gibt das erste Element einer Liste wieder.
first([E|_], E).


% ########## ab hier beginnt die urspruengliche read_sent.pl #######

%   File   : /usr/lib/prolog/read_sent
%   Author : R.A.O'Keefe
%   Updated: 11 November 1983
%   Purpose: to provide a flexible input facility
%   Modified for NIP and generalised: Ken Johnson, 24 April 1987

/*  The main predicates provided by this file are
	read_until(+Delimiters, -Answer)
	read_line(-String)
	trim_blanks(+RawString, -Trimmed)
	read_sentence(-ListOfTokens).

	The effect of this version is slightly different from that of
	R O'Keefe's original, and I hope therefore more generally
	useful. The predicate "read_sentence(W)" instantiates W to be a
	list of atoms. For example if you type
		?- read_sentence(W).
	Prolog prompts
		|:
	You type, say
		Show me the way to go home.
	Prolog instantiates W to
		[show,me,the,way,to,go,home,.]
*/

/*  read_sentence(Words)
    reads characters up to the next period, which may be  several  lines
    distant from the start, skips to the end of that line, and turns the
    result  into  a  list of tokens.  It can happen that the sentence is
    not well formed, if say there is an unmatched double quote.  In that
    case all the characters will still be read, but chars_to_words  will
    fail  and  so  read_sentence  will fail.  read_sentence will NOT try to read
    another sentence.
*/

read_sentence(Words) :-
	read_until("!?.", Chars),
	is_newline(NL),
	read_until([NL], _),		% skip to end of line
	!,
	chars_to_words(Chars, Words),
	!.

/*  read_until(Delimiters, Answer)
    reads characters from the current input until  a  character  in  the
    Delimiters  string  is  read.  The characters are accumulated in the
    Answer string, and include the closing  delimiter.   Prolog  returns
    end-of-file as -1. The end of the file is always a delimiter.
*/

read_until(Delimiters, [Char|Rest]) :-
	get0(Char),
%        put_char(Char),
	read_until(Char, Delimiters, Rest).


read_until(Char, Delimiters, []) :-
	'readsent:memberchk'(Char, [-1|Delimiters]), !.
read_until(_, Delimiters, Rest) :-
	read_until(Delimiters, Rest).


%   The following predicates define useful character classes.

is_endfile(-1).

is_newline(10).

is_layout(Char) :-
	Char =< " ".			% includes tab, newline, ^S, &c

is_lower(Char) :-
	Char >= "a", Char =< "z".	% lower case letter

is_upper(Char) :-
	Char >= "A", Char =< "Z".	% upper case letter

is_letter(Char) :-
	D is Char\/32,			% D is Char forced to lower case
	D >= "a", D =< "z".		% D is a lower case letter.

is_letter(39).				% Apostrophe (Ken Johnson)
is_letter(45).				% Hyphen (Ken Johnson)

is_digit(Char) :-
	Char >= "0", Char =< "9".	% decimal digit

is_period(Char) :-
	'readsent:memberchk'(Char, ".!?").		% sentence terminator

is_punct(Char) :-
	'readsent:memberchk'(Char, ",;:").		% other punctuation mark

is_paren(Left,Right) :-			% brackets
	'readsent:memberchk'([Left,Right], ["()","[]","{}","<>"]).


/*  trim_blanks(RawInput, Cleaned)
    removes leading and trailing layout characters  from  RawInput,  and
    replaces  internal  groups  of  layout  characters by single spaces.
    Thus trim_blanks(<|TAB TAB a SP ^M ^E b ^Z|>, "a b") would be true.
*/
trim_blanks([Char|Chars], Cleaned) :-
	is_layout(Char), !,
	trim_blanks(Chars, Cleaned).
trim_blanks([Char|Chars], [Char|Cleaned]) :- !,
	trim_blanks_rest_word(Chars, Cleaned).
trim_blanks([], []).


trim_blanks_rest_word([Char|Chars], Cleaned) :-
	is_layout(Char), !,
	trim_blanks_next_word(Chars, Cleaned).
trim_blanks_rest_word([Char|Chars], [Char|Cleaned]) :- !,
	trim_blanks_rest_word(Chars, Cleaned).
trim_blanks_rest_word([], []).


trim_blanks_next_word([Char|Chars], Cleaned) :-
	is_layout(Char), !,
	trim_blanks_next_word(Chars, Cleaned).
trim_blanks_next_word([Char|Chars], [32,Char|Cleaned]) :- !,
	trim_blanks_rest_word(Chars, Cleaned).
trim_blanks_next_word([], []).



/*  chars_to_words(Chars, Words)
    parses a list of characters (read by read_until) into a list of
    tokens,
*/

chars_to_words(Chars,Words) :-
        chars_to_words(Words,Chars,[]).

chars_to_words([Word|Words],A,B) :-
        chars_to_word(Word,A,C),  !,
        chars_to_words(Words,C,B).

chars_to_words([],A,A).


chars_to_word(Word,A,B) :-
        'C'(A,Char,C),
        is_layout(Char),  !,
        chars_to_word(Word,C,B).

chars_to_word(Word,A,B) :-
        'C'(A,Char,C),
        is_letter(Char),  !,
        chars_to_atom(Chars,C,B),
        case_shift([Char|Chars],Name),
        name(Word,Name).

chars_to_word(Word,A,B) :-
        'C'(A,Char,C),
        is_digit(Char),  !,
        Init is Char-48,
        chars_to_integer(Init,Word,C,B).

chars_to_word(Word,A,B) :-
        'C'(A,Quote,C),
        Quote is 34,  !,
        chars_to_string(Quote,String,C,B),
        name(Word,String).

chars_to_word(Punct,A,B) :-
        'C'(A,Char,B),
        name(Punct,[Char]).

/*  chars_to_atom(Tail)
    reads the remaining characters of a word.  Case conversion  is  left
    to  another  routine.   In this application, a word may only contain
    letters but they may be in either case.  If you want to parse French
    you will have to decide what to do about accents.  I suggest putting
    them after the vowel, and adding a clause
	chars_to_atom([Vowel,Accent|Chars]) -->
		[Vowel],	{accentable_vowel(Vowel)},
		[Accent],	{accent_for(Vowel, Accent)},
		!.
	with the obvious definitions of accentable_vowel and accent_for.
    Note that the Ascii characters ' ` ^ are officially  designated  the
    "accent acute", "accent grave", and "circumflex".  But this file was
    originally written for an English parser and there was no problem.
*/


chars_to_atom([Char|Chars],A,B) :-
        'C'(A,Char,C),
        is_letter(Char),  !,
        chars_to_atom(Chars,C,B).

chars_to_atom([],A,A).

/*  case_shift(Mixed, Lower)
    converts all the upper case letters in Mixed to lower  case.   Other
    characters (not necessarily letters!) are left alone.  If you decide
    to accept other characters in words only chars_to_atom has to alter.
*/

case_shift([Upper|Mixed], [Letter|Lower]) :-
	is_upper(Upper),
	Letter is Upper-"A"+"a", !,
	case_shift(Mixed, Lower).
case_shift([Other|Mixed], [Other|Lower]) :-
	case_shift(Mixed, Lower).
case_shift([], []).


/*  chars_to_integer(Init, Final)
    reads the remaining characters of an integer which starts  as  Init.
    NB:  this  parser  does  not  know about negative numbers or radices
    other than 10, as it was written for PDP-11 Prolog.
*/

chars_to_integer(Init,Final,A,B) :-
        'C'(A,Char,C),
        is_digit(Char),  !,
        Next is Init*10-48+Char,
        chars_to_integer(Next,Final,C,B).

chars_to_integer(Final,Final,A,A).

/*  chars_to_string(Quote, String)
    reads the rest of a string which was opened by  a  Quote  character.
    The  string is expected to end with a Quote as well.  If there isn't
    a matching Quote, the attempt to parse the  string  will  FAIL,  and
    thus the whole parse will FAIL.  I would prefer to give some sort of
    error  message and try to recover but that is application dependent.
    Two adjacent Quotes are taken as one, as they are in Prolog itself.
*/

chars_to_string(Quote,[Quote|String],A,B) :-
        'C'(A,Quote,C),
        'C'(C,Quote,D),  !,
        chars_to_string(Quote,String,D,B).

chars_to_string(Quote,[],A,B) :-
        'C'(A,Quote,B),  !.

chars_to_string(Quote,[Char|String],A,B) :-
        'C'(A,Char,C),  !,
        chars_to_string(Quote,String,C,B).

/*  read_line(Chars)
    reads characters up to the next newline or the end of the file, and
    returns them in a list, including the newline or end of file.  When
    you want multiple spaces crushed out, and the newline dropped, that
    is most of the time, call trim_blanks on the result.
*/
read_line(Chars) :-
	is_newline(NL),
	read_until([NL], Chars).


% Utility

'readsent:memberchk'(A,[A|_]) :-
	!.

'readsent:memberchk'(A, [_|B]) :-
	'readsent:memberchk'(A,B).


