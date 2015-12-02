/*
1)

b(x,y)
b(Y,X)
->Y=x, X=y

t(r,i)
t(Z,Z)
->scheitert

h(g(F,k),g(k,F))
h(g(m,H),g(H,m))
->F=m, H=k

m(X,c(g),h(X))
m(t(r,s),c(u),h(g(T)),t)
->scheitert

false
not(true)
->scheitert

False
not(true)
->False=not(true)
*/



peano_sub(Sub,0,Ergebnis) :- Ergebnis = Sub.
peano_sub(s(Sub),s(Subtrahend),Ergebnis) :- peano_sub(Sub, Subtrahend,Ergebnis).


peano2int(0,0).
peano2int(s(P),N) :- 
peano2int(P,N1), 
N is N1 + 1.