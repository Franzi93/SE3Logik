nextto(X,Y,[X,Y|L]).
nextto(X,Y,[_|L]):-nextto(X,Y,L).

nth0(0,[Element|RL],Element).
nth0(I,[_|RL],Element):-
I2 is I -1,
nth0(I2,RL,Element).

max_mem(Max,[F|RL]):-max_mem(Max,[F|RL],F).
max_mem(Max,[],Max).
max_mem(Max,[F|RL],Akku):-
F>Akku -> 
max_mem(Max,RL,F);
max_mem(Max,RL,Akku).
