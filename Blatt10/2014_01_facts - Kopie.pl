:- use_module(library(http/json)).

json_convert(From, To):-
open(To,write,Tstr),
open(From, read, Fstr),
json_read(Fstr,Res),
write(Tstr,Res).

%energy_time_series(Bezeichnung, Date, Timezone, Values)
:- dynamic energy_time_series/4.

json_daten(Akku):-
open('month_2014_01.json', read, Str),
json_read(Str,Res),
length(Res,L),
Akku<L,
nth0(Akku,Res,X),
assert(X),
Akku1 is Akku +1,
json_daten(Akku1).

:- json_daten(0).

energy_time_series_erzeuger():-
 json(J), 
 nth0(0,J,Bezeichnung), Bezeichnung = (key=[json([(en=Bez)|_])]),
 nth0(1,J,D), 
 assert(energy_time_series(Bez,Date,Time,Values))