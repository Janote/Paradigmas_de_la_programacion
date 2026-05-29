esRotacion(XS,RS) :- append(YS,ZS,RS), append(ZS,YS,XS).

collatz(N,N).
collatz(N,S) :- N > 1,      N mod 2 =:= 0,  N1 is N / 2 , collatz(N1,S).
collatz(N,S) :- N > 1,     N mod 2 =:= 1,  N1 is 3 * N + 1 , collatz(N1,S).

collatzMayor(N,M) :- collatz(N,M) , \+ (collatz(N,M1), M1 > M).