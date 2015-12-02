% liegt_stromaufwaerts_von(Fluss,Ort1,Ort2,Distanz)
% ist wahr, wenn fuer zwei an einem Fluss liegende
% Ortschaften die natuerliche Fliessrichtung des Wassers von
% Ort1 zu Ort2 verlaeuft
% Distanz ist die Entfernung zwischen diesen Orten in Kilometern

stromaufwaerts(moldau,praha,muendung_moldau,38).

stromaufwaerts(elbe,muendung_moldau,usti,70).
stromaufwaerts(elbe,usti,dresden,93).
stromaufwaerts(elbe,dresden,meissen,26).
stromaufwaerts(elbe,meissen,torgau,73).
stromaufwaerts(elbe,torgau,rosslau,102).
stromaufwaerts(elbe,rosslau,muendung_saale,33).
stromaufwaerts(elbe,muendung_saale,magdeburg,35).
stromaufwaerts(elbe,magdeburg,elbe_havel_kanal_ende,33).
stromaufwaerts(elbe,elbe_havel_kanal_ende,tangermuende,30).
stromaufwaerts(elbe,tangermuende,muendung_havel,34).
stromaufwaerts(elbe,muendung_havel,wittenberge,31).
stromaufwaerts(elbe,wittenberge,schnackenburg,21).
stromaufwaerts(elbe,schnackenburg,geesthacht,111).
stromaufwaerts(elbe,geesthacht,hamburg,22).
stromaufwaerts(elbe,hamburg,muendung_elbe,125).

stromaufwaerts(saale,calbe,muendung_saale,20).
stromaufwaerts(saale,bernburg,calbe,16).
stromaufwaerts(saale,halle,bernburg,57).

stromaufwaerts(mulde,bitterfeld,rosslau,27).
stromaufwaerts(mulde,wurzen,bitterfeld,47).

stromaufwaerts(havel,havelberg,muendung_havel,3).
stromaufwaerts(havel,rathenow,havelberg,42).
stromaufwaerts(havel,brandenburg,elbe_havel_kanal_anfang,5).
stromaufwaerts(havel,elbe_havel_kanal_anfang,rathenow,42).
stromaufwaerts(havel,muendung_spree,brandenburg,55).

stromaufwaerts(spree,berlin_mitte,muendung_spree,14).


stromaufwaerts(oder,muendung_neisse,eisenhuettenstadt,11).
stromaufwaerts(oder,eisenhuettenstadt,frankfurt_oder,33).
stromaufwaerts(oder,frankfurt_oder,schwedt,111).
stromaufwaerts(oder,schwedt,szczecin,42).
stromaufwaerts(oder,szczecin,swinoujscie,61).

stromaufwaerts(ehk,elbe_havel_kanal_anfang,elbe_havel_kanal_ende,55).
stromaufwaerts(ehk,elbe_havel_kanal_ende,elbe_havel_kanal_anfang,55).

%3.1
:- dynamic ist_betroffen/2.
ist_betroffen(Unfall, Betroffen) :-
    stromaufwaerts(_, Unfall, Betroffen,_).
ist_betroffen(Unfall, Betroffen) :-
    stromaufwaerts(_,Unfall, Zwischen,_),
     ist_betroffen(Zwischen, Betroffen).

%Die Definition terminiert nicht wenn Zyklen vorhanden sind.

%Eigenschaften:
%eine Stadt liegt nicht stromaufwärts und stromabwärts einer anderen -> nicht symmetrisch
%eine Stadt liegt nicht stromaufwärts und stromabwärts von sich selbst -> nicht reflexiv
%eine Stadt liegt srtomaufwärts einer stromabwärts und aller weiter stromabwärts liegender Städte -> transitiv
%mehrere Städte können stromaufwärts einer Stadt liegen -> nicht funktional

%3.2
/*
?- ist_betroffen(bitterfeld, Alarm_auslösen).
Alarm_auslösen = rosslau ;
Alarm_auslösen = muendung_saale ;
Alarm_auslösen = magdeburg ;
Alarm_auslösen = tangermuende ;
Alarm_auslösen = muendung_havel ;
Alarm_auslösen = wittenberge ;
Alarm_auslösen = schnackenburg ;
Alarm_auslösen = geesthacht ;
Alarm_auslösen = hamburg ;
Alarm_auslösen = muendung_elbe .
*/

%3.3

:- dynamic ist_erreichbar/2.
% von a nach b oder b nach a:
ist_erreichbar(Ort1, Ort2) :-
    ist_betroffen(Ort1, Ort2);
    ist_betroffen(Ort2, Ort1).

:- dynamic ist_erreichbar_richtungswechsel/2.
% wie ist_erreichbar oder fluss auf, dann abwärts:
ist_erreichbar_richtungswechsel(Ort1, Ort2) :-
    ist_erreichbar(Ort1,Ort2);
    (ist_betroffen(Ort1, Z),ist_betroffen(Ort2, Z)).

%3.4

%Die Endpunkte des Elbe-Havel-Kanals wurden in die Datenbank eingepflegt
%Zusätzlich wurde eine Verbindung in beide Richtungen zwischen Anfang
%und Ende angelegt. Das führt bei ist_betroffen/2 und ist_erreichbar/2 zu Zyklen.
Man kann die Zyklen verhindern, indem man sich merkt, welche Orte man bereits durchlaufen hat
und diese ignoriert, wenn man sie erneut erreicht.