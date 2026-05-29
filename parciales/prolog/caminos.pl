desde(X,X).
desde(X,Y) :- nonvar(Y), Y > X.
desde(X,Y) :- var(Y), N is X+1, desde(N,Y).


caminoDesde(P,[P|C]) :- desde(1,N), caminosDeLargoN(N,P,C).

caminosDeLargoN(0,_,[]).
caminosDeLargoN(N,(X,Y),[(X,Y1)|YS]) :- N > 0, N1 is N-1, Y1 is Y + 1, caminosDeLargoN(N1,(X,Y1),YS).
caminosDeLargoN(N,(X,Y),[(X,Y1)|YS]) :- N > 0, N1 is N-1, Y1 is Y - 1, caminosDeLargoN(N1,(X,Y1),YS).
caminosDeLargoN(N,(X,Y),[(X1,Y)|YS]) :- N > 0, N1 is N-1, X1 is X + 1, caminosDeLargoN(N1,(X1,Y),YS).
caminosDeLargoN(N,(X,Y),[(X1,Y)|YS]) :- N > 0, N1 is N-1, X1 is X - 1, caminosDeLargoN(N1,(X1,Y),YS).


objeto(1,50,10).
objeto(2,75,15).
objeto(3,60,5).
objeto(4,10,1).


mochila(C, L) :-
    mochilaDesde(C, 0, L).

mochilaDesde(C, _, []) :-
    C >= 0.
    
mochilaDesde(C, MinId, [ID|XS]) :-
    objeto(ID, P, _),
    ID > MinId,
    C1 is C - P,
    C1 >= 0,
    mochilaDesde(C1, ID, XS).