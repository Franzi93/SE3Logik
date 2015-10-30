:- dynamic buch/3.

% buch(Buchnr, Buchname, Autor).
buch(1, future_war, coker).
buch(2, hunger_games, collins).
buch(3, twilight, meyer).
buch(4, hitchhiker, adams).

:- dynamic nutzer/3.

% nutzer(Nutzernr, Nutzername, Nutzervorname)
nutzer(1, neu, franziska).
nutzer(2, engelken, ralf).

:- dynamic entliehen/4.

% entliehen(Vorgangsnr, Buchnr, Nutzernr, Datum)
% Datumsangaben haben die Struktur JJJJMMTT 
entliehen(1, 2, 1, 20150718).
entliehen(2, 3, 1, 20150815).
entliehen(3, 1, 2, 20151001).
