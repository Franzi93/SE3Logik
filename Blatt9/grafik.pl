% draw(Size)
% draws a graphics with a given Size

draw(Size) :-
   % prepare a Display to draw the object on
   % generate a new display name
   gensym(w,Display),
   free(@Display),
   % define size of the display (picture size + scroll bar area)
   SizeD is Size+20,
   % create a new display and open it
   new(@Display,picture('baeumses',size(SizeD,SizeD))),
   send(@Display,open),
   send(@Display,background,colour(black)), %* MK: ggf. Farbe auf 'white' stellen

   % draw the object on the display
   (
        draw_object(@Display);
        true
   ),
   % if desired save the display as .jpg
   write_ln('Save the graphics (y/n): '),
   get_single_char(A),
   put_code(A),nl,
   (A=:=121 ->
     (write_ln('enter file name: '),
      read_line_to_codes(user_input,X),
      atom_codes(File,X),
      atom_concat(File,'.jpg',FileName),
      get(@Display,image,Image),
      send(Image,save,FileName,jpeg) ) ; true ),

   !.

draw_tree(_,_,_,_,Height,Height).
draw_tree(Name, Size, X, Y,Height,Akku):-
	
	Yu = Y+Size + (Akku *10),
	Yo = Y+(Akku*10),
	Xl is X - (Akku*3),
	Xr is X + Size + (Akku*3),
	Xh is X + Size/2,
	send(Name, display, new(P, path)),
    send(P, append, point(Xl, Yu)),
    send(P, append, point(Xr, Yu)),
	send(P, append, point(Xh, Yo)),	
	send(P, append, point(Xl, Yu)),
	GColour is 65535 - (Akku * 1000),
	gensym(c,CName),
	new(CObj,colour(CName,0,GColour,0,rgb)),
    send(P,colour(CObj)),
	NewHeight is Akku+1,
	draw_tree(Name, Size, X, Y, Height,NewHeight).

% draw_object(Display,Size,CurrentSize,*** add additional parameters here, if needed ***)
% draws a gradient graphics of size Size into Display

draw_object(Name) :- 
  
 
 draw_tree(Name, 50, 10,10, 40,0),
 draw_tree(Name, 60, 100, 50, 50,0),
 draw_tree(Name, 50, 200, 10, 40,0).



% Call the program and see the result
:- draw( 800 ).   % specify the desired display size in pixel here (required argument)   


% ========== Tests from XPCE-guide Ch 5 ==========

% destroy objects
mkfree :-
   free(@p),
   free(@bo),
   free(@ci),
   free(@bm),
   free(@tx),
   free(@bz).

% create picture / window
mkp :-
   new( @p , picture('Demo Picture') ) ,
   send( @p , open ).

% generate objects in picture / window
mkbo :-
   send( @p , display , new(@bo,box(100,100)) ).
mkci :-
   send( @p , display , new(@ci,circle(50)) , point(25,25) ).
mkbm :-
   send( @p , display , new(@bm,bitmap('32x32/books.xpm')) , point(100,100) ).
mktx :-
   send( @p , display , new(@tx,text('Hello')) , point(120,50) ).
mkbz :-
   send( @p , display , new(@bz,bezier_curve(
	 point(50,100),point(120,132),point(50,160),point(120,200))) ).

% modify objects
mkboc :-
   send( @bo , radius , 10 ).
mkcic :-
   send( @ci , fill_pattern , colour(orange) ).
mktxc :-
   send( @tx , font , font(times,bold,18) ).
mkbzc :-
   send( @bz , arrows , both ).

