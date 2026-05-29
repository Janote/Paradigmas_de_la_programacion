desde(X,X).
desde(X,Y) :- nonvar(Y), Y > X.
desde(X,Y) :- var(Y), N is X+1, desde(N,Y).


generarCapicuas(L) :- desde(1,N), listasQueSumanN(N,L) , esCapicua(L).

listasQueSumanN(0,[]).
listasQueSumanN(N,[X|XS]) :- between(1,N,X) , Resto is N - X, listasQueSumanN(Resto,XS).

esCapicua(L) :- reverse(L,L).
