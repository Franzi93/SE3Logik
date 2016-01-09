% Jonas Pepperling
% 27.12.2012
% Chetto 1.0


% Laden der benötigten Dateien.
% Dies ist die read_sent.pl Datei. Mit ihr ist eine schönere Frage und
% Antwort Routine möglich.
:- consult(read_sent).

% Noch ein bischen anderer Kram am Anfang.
:- dynamic name/1.
:- dynamic gegessen/2.
:- dynamic getrunken/1.

% Dies ist nur der Willkommensgruß.
start :-
   write('Hallo, ich bin Chetto 1.0!'), nl,
   write('Für Hilfe ruf einfach "hilfe." auf.'), nl,
   write('Zum beenden schreibe einfach "ende." in die Konsole.'),nl,
   write('Erzähl mir doch was du Weihnachten so gemacht hast.'),nl,
   % assert(name(namenloser)),
   chetto. 

% Dies ist die eigentlich Interaktionszyklus. Er ist recht klein und 
% funktioniert Rekursiv.
% Es wird eine Eingabe entgegen genommen. Dann wird mit 'satz' geguckt ob 
% Chetto eine Antwort kennt.
chetto :- 
   read_sentence(Eingabe),
   satz(Eingabe,Ausgabe),
   ausgabe_schreiben(Ausgabe),
   nl,
   chetto.

% Mit diesem Prädikat ist das ausgaben von Listen möglich. Dabei wird die Liste
% mittels write geschrieben. Zwischen den Elementen wird immer ein Leerzeichen 
% eingefügt.
% [ich,esse,gerne,fisch,.] wird zu: 'ich esse gerne fisch .'
ausgabe_schreiben([]).
ausgabe_schreiben([Kopf|Rest]) :-
   write(Kopf),
   write(' '),
   ausgabe_schreiben(Rest).

% Hier sind mehrere Sätzefragmente, wobei immer bestimmte Stichworte mit 
% dem Input unifizieren. 
% Basierend darauf werden die Antworten generiert. 

% Zeigt die Hilfe-Datei an.
satz([hilfe,.],[]) :- 
   write('|---------------------------------|'),nl,
   write('Hilfedatei:'),nl,
   write('Am Ende der Eingabe muss ein Satzzeichen folgen.'),nl,
   write(' '),nl,
   write('Beispiel: Mein Name ist Peter.'),nl,
   write('Beispiel Frage: Wie heißt du?'),nl,
   write('Für eine Liste, was Chetto alles kann frage ihn:'),nl,
   write('   Was kannst du?.'),
   nl,
   write('|---------------------------------|'),
   nl.

% verschiedene Arten das Programm zu beenden.
satz([ende,.],[auf, wiedersehen,'!']) :- halt.
satz([halt,.],[auf, wiedersehen,'!']) :- halt.
satz([quit,.],[auf, wiedersehen,'!']) :- halt.
satz([exit,.],[auf, wiedersehen,'!']) :- halt.

% Wenn man ihn fragt, was er kann.
satz([was,kannst,du,?],[ich, kann, viele, tolle, sachen,'!']).

% Hier wird Chetto der Name des Benutzers beigebracht.
% Der Name steht dann im Prädikat Name. Es kann immer nur einen
% Namen geben, da Chetto davon ausgeht das er nur einen
% Gesprächspartner hat.
satz(Liste,Ausgabe) :-   
   random(1,6,Zufallszahl),
  ( 
   Liste = [mein,name,ist,Name|_];
   Liste = [mein, name, lautet, Name|_];                
   Liste = [ich, heiße, Name|_];                
   Liste = [ich, bin, Name|_];                                  
   Liste = [mein, name, ist, Name|_];                   
   Liste = [man, nennt, mich, Name|_]
  ),
    retractall(name(_)),assert(name(Name)),
   ((atom_length(Name,Laenge), 
     Laenge < 15)
->(
   (Zufallszahl = 1, Ausgabe = [hallo,Name,'!']);                  
   (Zufallszahl = 2, Ausgabe = [Name,'?',ein, toller,name,.]);       
   (Zufallszahl = 3, Ausgabe = [guten, tag, Name,.]);             
   (Zufallszahl = 4, Ausgabe = [freut, mich, dich, kenne, zu, lernen, Name,.]);
   (Zufallszahl = 5, Ausgabe = [moin, Name,.])                 
  )
  ; Ausgabe = [der, name, erscheint, mir, ein, wenig, zu, lang]).

% Chetto wird nach seinem Namen gefragt. Die Ausgabe wird zufällig und
% und unabhägig von der Eingabe ausgewählt.
satz(Liste, Ausgabe) :-
   random(1,6,Zufallszahl), 
   (  
    Liste = [wie, hei, ß, t, du|_];
    Liste = [wer, bist, du, denn|_];
    Liste = [wie, lautet, dein, name|_];
    Liste = [wie, nennt, man, dich|_];
    Liste = [sag, mir, deinen, namen|_];
    Liste = [wer,bist,du|_]
  ),
  ((Zufallszahl = 1, Ausgabe = [mein,name,ist,chetto,.]);  
   (Zufallszahl = 2, Ausgabe = [ich, bin, chetto,.]);        
   (Zufallszahl = 3, Ausgabe = [man, nennt, mich, chetto,.]); 
   (Zufallszahl = 4, Ausgabe = [ich,heiße,chetto,.]);
   (Zufallszahl = 5, Ausgabe = [mein, meister,hat,mir,den,namen,chetto,gegeben,.]) 
  ).

% Ein kleiner Scherz.
satz([42|_],[die,antwort,auf,die,frage,nach,dem,leben,dem,universum,und,den,ganzen,rest]). 

satz([hallo|_],Ausgabe) :- (name(Name) -> (Ausgabe = [hallo,Name,.]);Ausgabe = [hallo,.]).
satz([tsch,ü,ss|_],[auf, wiedersehen,'.']).
satz([ja|_],[okay,.]).
satz([nein|_],[das, ist, schade,.]).
satz([danke|_],[bitte,.]).
satz([start|_],[ich, bin, schon, in, betrieb,.]).
satz([wie, geht, es, dir,?],[mir, geht, es, gut,.]). 
satz([magst, du, weihnachten,'?'],[ja,,,weihnachten, ist, toll,.]).

% Chetto kann sich merken was der Benutzer alles gegessen hat.
satz([ich, habe, Anzahl, Art, gegessen,.],[ich, hoffe,dir,haben,die,Anzahl,Art,geschmeckt,.]) :- 
   assert(gegessen(Anzahl,Art)).

% Chetto kann sich auch merken was der Benutzer getrunken hat.
satz([ich,habe,Trinken,getrunken,.],[hoffentlich,war,im,Trinken,nicht,zu,viel,alkohol,.]) :-
   assert(getrunken(Trinken)).

% Chetto sagt dem Benuter was er über das Ess- oder Trinkverhalten.
satz([was, habe, ich, alles, gegessen|_],Ausgabe) :-   
   gegessen(_,_)
 ->(findall([du,hast,Anzahl,Art,gegessen,.],gegessen(Anzahl,Art),Ausgabe1),
      flatten(Ausgabe1,Ausgabe))
  ; Ausgabe = [du,hast,mir,noch,nicht,gesagt,was,es,zu,essen,gab,.]. 

satz([was,habe,ich,alles,getrunken|_],Ausgabe) :-
   getrunken(_)
 ->(findall([du,hast,Trinken,getrunken,.],getrunken(Trinken),Ausgabe1),
   flatten(Ausgabe1,Ausgabe))
  ;Ausgabe = [du,hast,mir,noch,nicht,verraten,was,es,zu,trinken,gab,.].

% Reaktion wenn Chetto etwas nicht verstehen kann.
% Dabei wird einer von 3 Sätzen zufällig ausgewählt.
% Muss als letztes stehen, da es ja immer Erfolgreich ist
% und nach einem Erfolg abgebrochen wird.

satz(_,Ausgabe) :- 
   random(1,4,Zufallszahl),(
   (Zufallszahl = 1, Ausgabe = [wie,bitte,?]);
   (Zufallszahl = 2, Ausgabe = [ich, habe, dich, leider, nicht, verstanden,.]);
   (Zufallszahl = 3, Ausgabe = [was, versuchst,du,mir,zu,sage,?])).

% Startet Chetto.
% Funktioniert leider nicht einwandfrei, daher auskommentiert!
:- nl, start.


/*
Hier mal ein Beispieldialog:

?- start.
Hallo, ich bin Chetto 1.0!
Für Hilfe ruf einfach "hilfe." auf.
Zum beenden schreibe einfach "ende." in die Konsole.
Erzähl mir doch was du Weihnachten so gemacht hast.
|: hallo.
hallo . 
|: wie heißt du?
ich heiße chetto . 
|: mein name ist jonas.
moin jonas . 
|: wie geht es dir?
mir geht es gut . 
|: magst du weihnachten?
ja , weihnachten ist toll . 
|: was habe ich alles gegessen?
du hast mir noch nicht gesagt was es zu essen gab . 
|: ich habe 25 kekse gegessen.
ich hoffe dir haben 25 kekse geschmeckt . 
|: ich habe 3 kuchen gegessen.
ich hoffe dir haben 3 kuchen geschmeckt . 
|: was habe ich alles gegessen?
du hast 25 kekse gegessen . du hast 3 kuchen gegessen .
|: danke.
bitte  
|: asdfasdf.
ich habe dich leider nicht verstanden . 
|: asdf.
was versuchst du mir zu sage ? 
|: tschüss.
auf wiedersehen . 
*/
