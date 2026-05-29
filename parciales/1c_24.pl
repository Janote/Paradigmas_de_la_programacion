subsecuenciaCreciente(XS,S) :- subsecuencia(XS,S), esCreciente(S).


esCreciente([]).
esCreciente([_]).
esCreciente([X,Y|XS]) :- X =< Y , esCreciente([Y|XS]).

subsecuencia(XS,S) :- prefijo(XS,PF), sufijo(PF,S).

prefijo(XS,PF) :- append(PF,_,XS).

sufijo(XS,SF) :- append(_,SF,XS).

subsecuenciaCrecienteMasLarga(XS,S) :- subsecuenciaCreciente(XS,S) , length(S,N) , \+ (subsecuenciaCreciente(XS,S1), length(S1,N1), N1 > N).

fibonacci(X) :- desde(0,N) , secuenciaFibonacci(N,X).

secuenciaFibonacci(0,1).
secuenciaFibonacci(1,1).
secuenciaFibonacci(N,X) :- N >= 2, N1 is N - 1, N2 is N - 2, secuenciaFibonacci(N1,X1) , secuenciaFibonacci(N2,X2), X is X1 + X2.

desde(X,X).
desde(X,N) :- X1 is X + 1, desde(X1,N).  

capicua(L) :- desde(0,N), listasQueSumanN(N,L) , esCapicua(L).

listasQueSumanN(0,[]).
listasQueSumanN(N,[X|XS]) :- between(1,N,X) , N1 is N - X , N1 >= 0, listasQueSumanN(N1,XS).

esCapicua(L) :- reverse(L,L).

prefijov2(PF,RS,XS) :- append(PF,RS,XS). 

tokenizar(D,[],[]).
tokenizar(D,F,[T|TS]) :- prefijov2(T,RS,F), member(T,D), length(T,N), N > 0, tokenizar(D,RS,TS). 




subsecuenciaRepetida([],[]).
subsecuenciaRepetida([X|XS],S) :- subsecuencia(X,S), length(S,N), N > 0 , perteneceAelResto(S,XS).

perteneceAelResto(_,[]).
perteneceAelResto(S,[X|XS]) :- subsecuencia(X,S), perteneceAelResto(S,XS).


secuenciaMaxima(M,S) :- subsecuenciaRepetida(M,S) , length(S,N),\+ (subsecuenciaRepetida(M,S1), length(S1,N1), N1 > N).

todasLasMatrices(M) :- desde(1,N), generarMatricesDeN(N,M).

generarMatricesDeN(N,M) :- between(1,N,Col), Fil is N - Col,  generarMatrizNxM(Fil,Col,M).

generardesdeMatrizNxM(N,M,Mat) :- length(Mat,N), generarFilas(M,Mat).

generarFilas(_,[]).
generarFilas(N,[X|XS]) :- length(X,N) , generarFilas(N,XS).


