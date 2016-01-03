% draw(Size)
% draws a line graphics based on a spiral structure
draw(Size) :-
   % prepare a Display to draw the object on
   % generate a new display name
   gensym(w,Display),
   free(@Display),
   % define size of the display (picture size + scroll bar area)
   SizeNew is Size+20,
   % create a new display and open it
   new(@Display,picture('Wolfgang Menzel 07',size(SizeNew,SizeNew))),
   send(@Display,open),
   send(@Display,background,colour(black)),
   SizeObject is Size/2.5,   
   % draw the object on the display
   ( 
   	draw_object(@Display,1,SizeObject);
	not(fail)
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


% draw_object(Display,Angle,Radius)
% draws a line graphics on a spiral structure
% with initial radius Radius onto Display
% Radius is decreased recursively from its initial value to 0
draw_object(_,_,X) :- X<5.
draw_object(Name,Angle,Radius) :-
  % decrement radius and increment angle
  RadiusNew is Radius - 2/sqrt(Radius),
  AngleNew is Angle + 0.2,
  % determine the end points of the current line
  Xfrom is RadiusNew * 1.5 * cos(Angle)/1.5 + 200,
  Yfrom is RadiusNew * 1.5 * sin(Angle)/1.5 + 200,
  Xto is RadiusNew * 0.8 * cos(Angle+0.2)/1.5 + 200,
  Yto is RadiusNew * 1.5 * sin(Angle+0.2)/1.5 + 200,
  % draw the line
  send(Name,display,new(L,line(Xfrom,Yfrom,Xto,Yto))),
  % create a new colour object and send it to the current line
  RColour is 65535,
  GColour is 65535-Radius*250,
  BColour is 0,
  gensym(c,CName),
  new(CObj,colour(CName,RColour,GColour,BColour,rgb)),
  send(L,colour(CObj)),
  % call draw_object recursively
  draw_object(Name,AngleNew,RadiusNew).

:- draw(400).
