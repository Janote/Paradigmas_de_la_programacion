desde(X,X).
desde(X,Y) :- nonvar(Y), Y > X.
desde(X,Y) :- var(Y), N is X+1, desde(N,Y).


unico(L,U) :- append(XS,[U|YS],L), \+ member(U,XS), \+ member(U,YS).

sinRepetidos(L) :- todosSonUnicos(L,L).

todosSonUnicos(_,[]).
todosSonUnicos(L,[X|XS]) :- unico(L,X), todosSonUnicos(L,XS).

formula(VS,F) :- desde(1,N), formulasDeLargoN(N,VS,F).


formulasDeLargoN(1,VS,F) :- member(F,VS).
formulasDeLargoN(N,VS,neg(F)) :- N > 1 ,N1 is N -1 , formulasDeLargoN(N1,VS,F).
formulasDeLargoN(N,VS,imp(P,Q)) :- N > 1,  between(1,N,Resto), Resto2 is N - Resto, Resto2 > 0, formulasDeLargoN(Resto,VS,P), formulasDeLargoN(Resto2,VS,Q).

