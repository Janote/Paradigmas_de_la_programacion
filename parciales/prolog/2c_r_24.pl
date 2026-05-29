desde(X,X).
desde(X,Y) :- nonvar(Y), Y > X.
desde(X,Y) :- var(Y), N is X+1, desde(N,Y).


subsecuenciaCreciente(XS,S) :- subsecuencia(XS,S) , esCreciente(S).
subsecuenciaCrecienteMasLarga(XS,S) :- subsecuencia(XS,S) , length(S,N), \+ (subsecuencia(XS,S1), length(S1,N1), N1 > N).

fibonacci(X) :- desde(0,N), generarFibonacci(N,X).

generarFibonacci(0,1).
generarFibonacci(1,1).
generarFibonacci(N,X) :- N > 1 , N1 is N - 1, N2 is N - 2, generarFibonacci(N1,X1), generarFibonacci(N2,X2), X is X1 + X2.



