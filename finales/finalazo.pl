progenitor(diego, dalma).
progenitor(diego, gianinna).

progenitor(tota, diego).
progenitor(chitoro, ana).
progenitor(ana, daniel).

parejaBase(gianinna, osvaldo).
parejaBase(chitoro, tota).
parejaBase(diego, claudia).
parejaBase(ana, pedro).

pareja(X, Y) :-
    parejaBase(X, Y).

pareja(X, Y) :-
    parejaBase(Y, X).

ancestro(A, X) :-
    progenitor(A, X).

ancestro(A, X) :-
    progenitor(A, Y),
    ancestro(Y, X).

descendientes(P, HS) :-
    findall(X, ancestro(P, X), DescSangre),
    buscarParejas(DescSangre, Parejas),
    findall(Z, (member(Y, Parejas), ancestro(Y, Z)), DescParejas),
    append(DescSangre, DescParejas, Todos),
    list_to_set(Todos, HS).

buscarParejas([], []).

buscarParejas([X|XS], [Y|YS]) :-
    pareja(X, Y),
    buscarParejas(XS, YS).

buscarParejas([X|XS], YS) :-
    \+ pareja(X, _),
    buscarParejas(XS, YS).


    