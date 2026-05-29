
comprimido([], []).

% Caso 1: no comprimo el bloque
comprimido(L1, L2) :-
    L1 = [X|_],
    tomarBloque(X, L1, Bloque, Resto),
    comprimido(Resto, RestoComprimido),
    append(Bloque, RestoComprimido, L2).

% Caso 2: comprimo el bloque
comprimido(L1, [c(X, K)|RestoComprimido]) :-
    L1 = [X|_],
    tomarBloque(X, L1, Bloque, Resto),
    length(Bloque, K),
    comprimido(Resto, RestoComprimido).

tomarBloque(_, [], [], []).
tomarBloque(X, [X|XS], [X|Bloque], Resto) :-
    tomarBloque(X, XS, Bloque, Resto).
tomarBloque(X, [Y|YS], [], [Y|YS]) :-
    X \= Y.


esTautologia(prop(_)).
esTautologia(not(X)) :- \+  esTautologia(X).
esTautologia(and(X,Y)) :- esTautologia(X) ,esTautologia(Y).
esTautologia(or(X,_)) :- esTautologia(X).
esTautologia(or(_,Y)) :- esTautologia(Y).
esTautologia(imp(P,Q)) :- esTautologia(Y).




