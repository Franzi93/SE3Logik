
:- dynamic(directory/5).
:- dynamic(file/6).

% directory(DirId,Name,ParentId,DateCreated,DateModified)

directory(1,root,0,date(2007,5,2),date(2007,5,2)).
directory(2,bilder,1,date(2007,5,2),date(2009,11,2)).
directory(3,musik,1,date(2007,5,2),date(2009,10,4)).
directory(4,dokumente,1,date(2007,5,2),date(2009,11,5)).
directory(5,urlaub,2,date(2008,6,22),date(2009,8,15)).
directory(6,hochzeit,2,date(2008,1,27),date(2008,1,31)).
directory(7,kinder,2,date(2007,5,2),date(2009,9,5)).
directory(8,klassik,3,date(2007,5,2),date(2007,5,2)).
directory(9,pop,3,date(2007,5,2),date(2009,11,5)).
directory(10,urlaub,4,date(2008,5,23),date(2008,11,1)).
directory(11,hochzeit,4,date(2007,12,4),date(2008,1,25)).
directory(12,scheidung,4,date(2009,9,2),date(2009,11,5)).

% file(FileId,DirId,Name,Size,DateCreated,DateModified)

file(1,9,in_the_summertime,56,date(2007,5,2),date(2009,11,5)).
file(2,9,i_am_so_romantic_tonight,31,date(2007,5,2),date(2009,11,5)).
file(3,9,ich_und_du_fuer_immer,67,date(2007,5,2),date(2009,11,5)).
file(4,9,paris,267,date(2008,6,3),date(2008,6,3)).
file(7,10,quartieranfrage,1,date(2007,5,2),date(2009,11,5)).
file(13,5,paris,251,date(2008,6,22),date(2008,6,17)).
file(14,5,dijon,217,date(2008,6,22),date(2008,6,17)).
file(15,5,die_bruecke_von_avignon,191,date(2008,6,22),date(2008,6,17)).
file(21,6,polterabend,238,date(2008,1,27),date(2008,1,31)).
file(22,6,standesamt,244,date(2008,1,27),date(2008,1,31)).
file(23,6,kirche,158,date(2008,1,28),date(2008,1,31)).
file(24,6,festessen,151,date(2008,1,28),date(2008,1,31)).
file(25,11,standesamt,33,date(2007,6,3),date(2007,6,3)).
file(34,12,scheidungsklage,48,date(2009,9,2),date(2009,11,5)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Blatt3
%Aufgabe 2
:- dynamic(datei_info/2).
datei_info(FileID,Name) :- file(FileID,_,Name,_,_,_).

:- dynamic(verzeichnis_info/2).
verzeichnis_info(DirID,Name) :- directory(DirID,Name,_,_,_).

:- dynamic(lokalisiere_datei/3).
lokalisiere_datei(FileName,DirID,DirName) :- file(FileID,DirID,FileName,_,_,_), directory(DirID,DirName,_,_,_).

:- dynamic(hoeheres_verzeichnis/3).
hoeheres_verzeichnis(DirName,DirID,ParentID,ParentName) :- directory(DirID,DirName,ParentID,_,_), directory(ParentID,ParentName,_,_,_).

%Aufgabe 3
:- dynamic(verzeichnis_inhalt/1).
verzeichnis_inhalt(DirID) :- findall(Filename, lokalisiere_datei(Filename, DirID,_),L), write(L).

:- dynamic(unterverzeichnisse/1).
unterverzeichnisse(DirID) :- findall(UdirName, hoeheres_verzeichnis(UdirName, _,DirID,_),L), write(L).

:- dynamic(anzahl_dateien/1).
anzahl_dateien(DirID) :-  findall(Filename, lokalisiere_datei(Filename, DirID,_),List), length(List, L), write(L).

%Aufgabe 4

%funzt nicht
:- dynamic(update_date/1).
update_date(DirID) :- assert(directory(DirID,Name,ParentId,DateCreated,date(2015,11,08))), retract(directory(DirID,_,_,_,DateModified)),
DateModified \= date(2015, 11, 08) .

:- flag(directories, _ , 13).
:- dynamic(new_subdir/2).
new_subdir(ParentDirID, SubDirName) :- flag(directories, X, X+1), assert(directory(X, SubDirName, ParentDirID, date(2015,11,08),date(2015,11,08))) .

:- flag(files, _ , 35).
:- dynamic(new_file/3).
new_file(DirID, FileName, Size) :- flag(files, X, X+1), assert(file(X,DirID,FileName,Size, date(2015,11,08),date(2015,11,08))) .



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Blatt5


%4.1
untervz(D1,D2) :- directory(D1,_,D2,_,_).
untervz(D1,D2) :- directory(D1,_,Z,_,_), untervz(Z,D2).
pfad(D1,D2) :- untervz(D1,D2);untervz(D2,D1).

/*
?- pfad(0,2).
true .

?- pfad(9,8).
false.

?- pfad(8,9).
false.

?- pfad(2,0).
true .

?- pfad(1,0).
true .

?- pfad(0,1).
true .
*/

%4.2
file_reachable(FileID) :- file(FileID,DirID,_,_,_,_), pfad(0,DirID).
/*
?- file_reachable(6).
false.

?- assert(file(6,13,bla,123,date(1234,11,11),date(1234,11,11))).
true.

?- file_reachable(6).
false.

?- file_reachable(7).
true .
*/

%4.3 gibt die IDs aller Unterverzeichnisse als Liste aus
untervz_list(DirID, List) :- findall(UDir,untervz(UDir, DirID), List).
/*
 ?- untervz_list(3, L).
L = [8,9].

 ?- untervz_list(0, L).
L = [1,2,3,4,5,6,7,8,9,10,11,12].
*/

%4.4
%gibt die Summe der Zahlen einer Liste wieder
%list_sum(?Liste,?Summe )
list_sum([],0).
list_sum([F|RL],Sum):- 
list_sum(RL,Sum1),
Sum is Sum1+F.

%gibt die Summe der Dateigroessen eines Verzeichnis wieder
%filesize_sum(?DirectoryID,?Summe)
filesize_sum(DirID,Size) :- 
findall(S,file(_,DirID,_,S,_,_),L),
list_sum(L,Size).

%gibt die Summe der Dateigrößen aller Unterverzeichnisse wieder
%filesize_sum2(?DirectoryID,?Summe)
filesize_sum2(DirID, Sum) :- 
untervz_list(DirID, L), 
filesize_subr(DirID, Sum, L).

filesize_subr(DirID,0,[]).
filesize_subr(DirID,Sum,[F|RL]):-
filesize_subr(DirID,Sum1,RL),
filesize_sum(F, S),
Sum is Sum1 + S.




