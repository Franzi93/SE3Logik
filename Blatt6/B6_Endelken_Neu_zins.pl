%Aufgabe 1

verzinsen(Betrag, Zins, Erg) :-
    Erg is Betrag * (100 + Zins) / 100.

:- verzinsen(100,5,105).

%Aufgabe 1.1
%zins_rec(+Anlagebetrag,+Zinsfaktor,+Anlagedauer,?Endguthaben)

zins_rec(Betrag, _, 0, Betrag).
zins_rec(Betrag, Zins, Dauer, Erg) :-
   DauerNeu is Dauer - 1,
   zins_rec(Betrag, Zins, DauerNeu, ErgAlt),
   verzinsen(ErgAlt, Zins, Erg).

:- zins_rec(100, 0, 0, 100).
:- zins_rec(100, 5, 0, 100).
:- zins_rec(100, 0, 5, 100).
:- zins_rec(100, 5, 1, 105).
:- zins_rec(100, 5, 2, 110.25).

%Aufgabe 1.2
zins_loop(Betrag, Zins, Dauer, Erg) :-
    Erg is Betrag,
    forall(between(1,Dauer,_),
        (Erg is (Betrag * (100 + Zins) / 100))).

:- zins_loop(100, 0, 0, 100).
:- zins_loop(100, 5, 0, 100).
:- zins_loop(100, 0, 5, 100).
%:- zins_loop(100, 5, 1, 105).
%:- zins_loop(100, 5, 2, 110.25).

%Aufgabe 1.3
zins_endrec(Betrag, _, 0, Betrag).
zins_endrec(Betrag, Zins, Dauer, Erg) :-
    BetragNeu is Betrag * (100 + Zins) / 100,
    DauerNeu is Dauer - 1,
    zins_endrec(BetragNeu, Zins, DauerNeu, Erg).

:- zins_endrec(100, 0, 0, 100).
:- zins_endrec(100, 5, 0, 100).
:- zins_endrec(100, 0, 5, 100).
:- zins_endrec(100, 5, 1, 105).
:- zins_endrec(100, 5, 2, 110.25).

%Aufgabe 1.4
%Bei der endrekursiven Variante muß ein weiterer Parameter eingeführt werden, in dem die bisherige Laufzeit übergeben wird,
%da der Zinssatz von ebenjener bisherigen Laufzeit abhängt.
%Bei der nicht-endrekursiven Variante kann die Dauer benutzt werden, da diese bei der Abarbeitung der Rekursionsschritte
%der bisherigen laufzeit entspricht.
%Es wurde die endrekursive Variante gewählt, da diese weniger komplex und somit leichter nachvollziehbar ist.

zinssatz_special(1, 3).
zinssatz_special(2, 4).
zinssatz_special(Jahr, Zins) :-
    VorJahr is Jahr - 1,
    VorVorJahr is Jahr - 2,
    zinssatz_special(VorJahr, VorZins),
    zinssatz_special(VorVorJahr, VorVorZins),
    Zins is VorZins + (VorZins - VorVorZins) / 2.

zins_special_int(Betrag, _, 0, Betrag).
zins_special_int(Betrag, Zaehler, Dauer, Erg) :-
    zinssatz_special(Zaehler, Zins),
    BetragNeu is Betrag * (100 + Zins) / 100,
    DauerNeu is Dauer - 1,
    ZaehlerNeu is Zaehler + 1,
    zins_special_int(BetragNeu, ZaehlerNeu, DauerNeu, Erg).

zins_special(Betrag, 0, Betrag).
zins_special(Betrag, Dauer, Erg) :-
    zins_special_int(Betrag, 1, Dauer, Erg).

:- zins_special(100,0,100).
:- zins_special(100,1,103).

%Aufgabe 1.5
besser_variabel(Dauer) :-
    Betrag is 100,
    zins_endrec(Betrag, 4, Dauer, ErgRec),
    zins_special(Betrag, Dauer, ErgSpecial),
    (ErgRec < ErgSpecial).