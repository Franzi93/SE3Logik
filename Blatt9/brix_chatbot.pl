% Uebungsblatt 9
% Hannes Brix 6374128
%
%
% rule (?Pattern,-Response)
%
% ich habe mich entschieden,'member' zu benutzen um möglichs offene
% Anfragen entgegen nehmen zu können.

%begruessung
rule(P,[hallo,',',wieso,stoeren,sie,mich,?,ich,habe,ferien,!]):-
	member(hallo,P).

rule(P,[hallo,',',wieso,stoeren,sie,mich,?,ich,habe,ferien,!]):-
	member(tag,P),
	member(guten,P).

rule(P,[hallo,',',wieso,stoeren,sie,mich,?,ich,habe,ferien,!]):-
	member(abend,P),
	member(guten,P).

rule(P,[hallo,',',wieso,stoeren,sie,mich,?,ich,habe,ferien,!]):-
	member(morgen,P),
	member(guten,P).


%ferien allgemein
rule(P,[die,ferien,',',die,ferien,',',ich,hoere,immer,nur,"die ferien",'.',es,wundert,mich,',',ueberhaupt,noch,zeit,zum,entspannen,zu,haben,'.',wehe,sie,wollen,auch,noch,etwas,ueber,weihnachten,wissen,'!']):-
	member(ferien,P).


%weihnachten im speziellen
rule(P,[puh,',',sie,haben,nerven,'.',was,wollen,sie,denn,hoeren,'?',ein,achso,schoenes,gedicht,',',ein,lied,oder,doch,ein,wohlschmeckendes,gericht,'?']):-
	member(weinachten,P).

rule(P,[ich,kann,nicht,singen,',',ich,bin,ein,chatbot,!]):-
	member(lied,P).

rule(P,[der,baum,ist,gruen,',',es,brennt,ein,licht,',',ich,glaub,ich,uebergebe,mich,'.']):-
	member(gedicht,P).

rule(P,[essen,sie,weniger,',',das,ist,gesund,',',wieviel,kg,fleisch,haben,sie,denn,eingekauft,'?']):-
	member(gericht,P).

rule(P,[sie,gefallen,mir]):-
	elementInt(P,A),
	A=0.

rule(P,[A,kg,sind,grade,noch,so,ok,'.',machen,sie,falschen,hasen,draus,'.']):-
	elementInt(P,A),
	A=<1,
	A>0.

rule(P,[waaas,',',A,kg,'?',viel,zu,viel,'!',am,besten,sie,verpacken,alles,und,verschenken,es,',',dann,haben,sie,sogar,zwei,fliegen,mit,einer,klappe,geschlagen,'.']):-
	elementInt(P,A),
	A<1.

%verabschiedung
rule(P,[tschuess,!]):-
	member(tschuess,P).

rule(P,[tschuess,!]):-
	member(bis,P),
	member(dann,P).

rule(P,[tschuess,!]):-
	member(wiedersehen,P).

rule(P,[tschuess,!]):-
	member(frohes,P).


%elementInt(?ListenElement,?Akku),hier wird gecheckt ob ein Element der
%Liste ein Integer ist, und dann auf dem Akku uebergeben.
%
elementInt([K|_],K):-
	integer(K).
elementInt([_|R],A):-
	elementInt(R,A).

% Anleitung:
% schreiben sie in kleinbuchstaben ihre frage oder bemerkung zum thema
% ferien oder weihnachten auf. verwenden sie die folgene formatierung:
% rule([wort,wort,...,!,?],X). zahlenangaben bitte in integern
% angeben und komata in anfuehrungszeichen ',' setzen.
%
% wenn man die datenbank erweitern würde, könnte man von spezifischen
% member moeglichkeiten, zB.:
% member(weihnachten),member(essen),member(gut),member('?'), zu
% allgemeineren moeglichkeiten z.B. nur "member(weihnachten)" abstufen
% und so antworten garantieren. man muss dann allerdings den
% cut-operator benutzen.
