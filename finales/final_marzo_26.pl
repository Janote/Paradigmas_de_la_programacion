progenitor(diego, dalma).
progenitor(diego, gianinna).

progenitor(tota, diego).
progenitor(chitoro, ana).
progenitor(ana, daniel).
progenitor(dalma,jano).
pareja(gianinna, osvaldo).
pareja(chitoro, tota).
pareja(diego, claudia).
pareja(ana, pedro).

pareja(X, Y) :-
    pareja(Y, X).

ancestro(A, X) :-
    progenitor(A, X).

ancestro(A, X) :-
    progenitor(A, Y),
    ancestro(Y, X).

descendientes(P, HS) :-
    findall(X, ancestro(P, X), DescSangre),
    buscarParejas(DescSangre, Parejas),
    findall(Z, (member(Y, Parejas), ancestro(Y, Z)), DescParejas),
    append(DescSangre, DescParejas, HS).



buscarParejas([X|XS], [Y|YS]) :-
    pareja(X, Y),
    buscarParejas(XS, YS).

buscarParejas([X|XS], YS) :-
    \+ pareja(X, _),
    buscarParejas(XS, YS).


ancestroComunMasCercano(P1,P2,A) :- ancestro(A,P1), ancestro(A,P2), 