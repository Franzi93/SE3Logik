:- use_module(library(http/json)).


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

json_export_anpassen():-
json(Funf),
length(Funf,5),
Funf = [A,B,C,D,E],
assert(json([A,C,E])),
retract(json(Funf)).

json_import_anpassen():-
json(Vier),
length(Vier,4),
Vier = [A,B,C,D],
assert(json([A,C,D])),
retract(json(Vier)).

second([F,S|_], S).
energy_time_series_erzeuger:-
 json([Bezeichnung, Color, values=Values]), 
 Bezeichnung = (key=[json([(en=Bez)|_])]),
 Values = [[Date,_],[Date2,_]|_] ,
 Time is Date2 - Date,
 maplist(second, Values,NValues),
 assert(energy_time_series(Bez,Date,Time,NValues)).
 
 
:- json_daten(0).
:- json_export_anpassen.
:- json_import_anpassen.

/*Anleitung: Mit backtracking das Prädikat energy_time_series_erzeuger 
durchlaufen lassen, danach sind alle energy_time_series Fakten in
der Datenbank.

1 ?- energy_time_series_erzeuger.
true ;
true ;
true ;
true ;
true ;
true ;
true ;
true ;
true ;
true ;
true ;
true ;
true ;
true.

2 ?- energy_time_series(A,B,C,D).
A = 'Hydro Power',
B = 1388530800000,
C = 3600000,
D = [2.108, 2.229, 2.073, 2.129, 2.058, 2.054, 1.962, 2.001, 1.964|...] ;
A = 'Biomass',
B = 1388530800000,
C = 3600000,
D = [5.705, 5.705, 5.705, 5.705, 5.705, 5.705, 5.705, 5.705, 5.705|...] ;
A = 'Uranium',
B = 1388530800000,
C = 3600000,
D = [11.873, 11.694, 11.587, 11.287, 11.058, 11.211, 11.329, 11.24, 10.803|...] ;
A = 'Brown Coal',
B = 1388530800000,
C = 3600000,
D = [16.339, 16.26, 16.116, 16.28, 15.726, 14.7, 14.197, 13.303, 13.369|...] ;
A = 'Hard Coal',
B = 1388530800000,
C = 3600000,
D = [3.619, 3.538, 3.548, 3.55, 3.586, 3.722, 3.819, 3.823, 3.691|...] ;
A = 'Gas',
B = 1388530800000,
C = 3600000,
D = [3.48, 3.461, 3.374, 3.327, 3.341, 3.354, 3.381, 3.39, 3.384|...] ;
A = 'Oil',
B = 1388530800000,
C = 3600000,
D = [0.138, 0.138, 0.138, 0.138, 0.138, 0.138, 0.138, 0.138, 0.138|...] ;
A = 'Others',
B = 1388530800000,
C = 3600000,
D = [0.217, 0.217, 0.217, 0.217, 0.192, 0.153, 0.145, 0.146, 0.148|...] ;
A = 'Pumped Storage',
B = 1388530800000,
C = 3600000,
D = [0.852, 0.519, 0.21, 0.07, 0.015, 0.021, 0.047, 0.055, 0.052|...] ;
A = 'Seasonal Storage',
B = 1388530800000,
C = 3600000,
D = [0.044, 0.136, 0.016, 0.112, 0.076, 0.085, 0.012, 0.054, 0.026|...] ;
A = 'Wind',
B = 1388530800000,
C = 3600000,
D = [8.503, 8.086, 8.803, 8.97, 8.51, 8.361, 8.046, 8.232, 8.38|...] ;
A = 'Solar',
B = 1388530800000,
C = 3600000,
D = [0, 0, 0, 0, 0, 0, 0, 0.001, 0.171|...] ;
A = 'Export',
B = 1388530800000,
C = 3600000,
D = [-8.086, -8.086, -8.177, -7.246, -6.369, -5.935, -7.226, -7.132, -5.739|...] ;
A = 'Import',
B = 1388530800000,
C = 3600000,
D = [0, 0, 0, 0, 0, 0, 0, 0, 0|...].
*/