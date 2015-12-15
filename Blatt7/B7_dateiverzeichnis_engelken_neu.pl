
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

%Aufgabe1.1
%direct_path(+Verzeichnis,?Pfad)
direct_path(0,[]).
direct_path(DirID, Path):-
directory(DirID,N,UDir,_,_),
direct_path(UDir,Part),
append(Part,[N],Path).
/*
?- direct_path(9,X).
X = [root, musik, pop] .

?- direct_path(A,X).
A = 0,
X = [] ;
A = 1,
X = [root] ;
A = 2,
X = [root, bilder] ;
A = 3,
X = [root, musik] ;
A = 4,
X = [root, dokumente] ;
A = 5,
X = [root, bilder, urlaub] ;
A = 6,
X = [root, bilder, hochzeit] ;
A = 7,
X = [root, bilder, kinder] ;
A = 8,
X = [root, musik, klassik] ;
A = 9,
X = [root, musik, pop] ;
A = 10,
X = [root, dokumente, urlaub] ;
A = 11,
X = [root, dokumente, hochzeit] ;
A = 12,
X = [root, dokumente, scheidung] ;
false.
*/

%Aufgabe 1.2
%file_path(+Verzeichnis, +Dateiname, ?Pfad)
file_path(DirID, Filename, Path):-
file(_,DirID,Filename,_,_,_),
direct_path(DirID,Path).

/*
?- file_path(X,paris,Y).
X = 9,
Y = [root, musik, pop] .

?-  file_path(9,X,Y).
X = in_the_summertime,
Y = [root, musik, pop] ;
X = i_am_so_romantic_tonight,
Y = [root, musik, pop] ;
X = ich_und_du_fuer_immer,
Y = [root, musik, pop] ;
X = paris,
Y = [root, musik, pop] ;

?- file_path(9,paris,Y).
Y = [root, musik, pop] .
*/

%Aufgabe1.3
%gibt die Liste L aller Dateien wieder, nach Änderungsdatum sortiert
%file_list_sorted(?Liste)
file_list_sorted(L):-
	findall([Change,ID,P],
		(file(ID,Dir,_,_,_,Change),
		file_path(Dir,_,P)),L2),
	sort(L2,L1),
	reverse(L1,L).

/*
?- file_list_sorted(A).
A = [[date(2009, 11, 5), 34, [root, dokumente, scheidung]], [date(2009, 11, 5), 7, [root, dokumente, urlaub]], [date(2009, 11, 5), 3, [root, musik, pop]], [date(2009, 11, 5), 2, [root, musik|...]], [date(2009, 11, 5), 1, [root|...]], [date(2008, 6, 17), 15, [...|...]], [date(2008, 6, 17), 14|...], [date(..., ..., ...)|...], [...|...]|...].
*/

%gibt die Liste der zuletzt geänderten Dateien wieder nach Anzahl der Grenze
%file_list(+Grenze, ?Liste)
file_list(Grenze,List):-
	file_list_sorted(L),
	length(L,A),
	file_list(Grenze,List,L).
file_list(0,[],_).
file_list(_,[],[]).  %diese Regel fängt den Fall Grenze>Faktenlänge ab
file_list(Grenze,List,[F|Fileliste]):-
	Grenze2 is Grenze-1,
	file_list(Grenze2,List2,Fileliste),
	append(List2,[F],List).

/*
?- file_list(2,L).
L = [[date(2009, 11, 5), 7, [root, dokumente, urlaub]], [date(2009, 11, 5), 34, [root, dokumente, scheidung]]] 

?- file_list(13,L).
L = [[date(2008, 1, 31), 21, [root, bilder, hochzeit]], [date(2008, 1, 31), 22, [root, bilder, hochzeit]], [date(2008, 1, 31), 23, [root, bilder, hochzeit]], [date(2008, 1, 31), 24, [root, bilder|...]], [date(2008, 6, 3), 4, [root|...]], [date(2008, 6, 17), 13, [...|...]], [date(2008, 6, 17), 14|...], [date(..., ..., ...)|...], [...|...]|...] 


%Faktenanzahl=14
 ?- file_list(15,L).
L = [[date(2007, 6, 3), 25, [root, dokumente, hochzeit]], [date(2008, 1, 31), 21, [root, bilder, hochzeit]], [date(2008, 1, 31), 22, [root, bilder, hochzeit]], [date(2008, 1, 31), 23, [root, bilder|...]], [date(2008, 1, 31), 24, [root|...]], [date(2008, 6, 3), 4, [...|...]], [date(2008, 6, 17), 13|...], [date(..., ..., ...)|...], [...|...]|...] .
*/


