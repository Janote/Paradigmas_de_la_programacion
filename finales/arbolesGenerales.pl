desde(X,X).
desde(X,N) :- X1 is X + 1, desde(X1,N).  

arbolGeneral(A) :- desde(0,N), arbolGeneralDeAlturaN(N,A).


arbolGeneralDeAlturaN(0,[]).
arbolGeneralDeAlturaN(1,x).
arbolGeneralDeAlturaN(N,Res) :- N > 1, between(0,N,N1), between(0,N,N2), arbolGeneralDeAlturaN(N1,XS), arbolGeneralDeAlturaN(N2,YS), append(XS,[x|YS],Res). 


coprimos(X,Y) :- desde(1,N), between(1,N,X) , Y is N - X, Y > 0, 1 is gcd(X,Y).
