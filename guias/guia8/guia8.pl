


%% Ejercicio 4 
juntar([],XS,XS).
juntar([X|XS],YS,[X|ZS]) :- juntar(XS,YS,ZS).

%% Ejercicio 5

last([X],X).
last([_|XS],Z) :- last(XS,Z).

reverse([],[]).
reverse([X|XS],ZS) :- reverse(XS,YS), append(YS,[X],ZS).

prefijo(P,L) :- append(P,_,L).

sufijo(S,L) :- append(_,S,L).


sublista(S,L) :- prefijo(P,L) , sufijo(S,P). 

pertenece(X,[X|_]).
pertenece(X,[Y|YS]) :- X \= Y , pertenece(X,YS).

%% Ejercicio 6 
aplanar([],[]).
aplanar([X|XS],[X|ZS]) :- not(is_list(X)), aplanar(XS,ZS).
aplanar([X|XS],ZS) :- is_list(X), aplanar(X,R), aplanar(XS,ZS1), append(R,ZS1,ZS).

%% Ejercicio 7

interseccion([],_,[]).
interseccion([X|XS],YS,[X|ZS]) :- member(X,YS), not(member(X,XS)), interseccion(XS,YS,ZS).
interseccion([X|XS],YS,ZS):- member(X,YS), member(X,XS), interseccion(XS,YS,ZS).
interseccion([X|XS],YS,ZS) :- not(member(X,YS)), interseccion(XS,YS,ZS).

partir(N,XS,L1,L2) :- append(L1,L2,XS) , length(L1,N).

borrar(L0,X,L0) :- not(member(X,L0)).
borrar(L0,X,LSX) :- append(L1,[X|L2],L0) , borrar(L1,X,LSX1), borrar(L2,X,LSX2), append(LSX1,LSX2,LSX).

sacarDuplicados([],[]).
sacarDuplicados([X|XS],[X|YS]) :- \+ member(X,XS), sacarDuplicados(XS,YS).
sacarDuplicados([X|XS],YS) :- member(X,XS), sacarDuplicados(XS,YS).


permutacion([],[]).
permutacion(XS,[X|YS]) :- append(L1,[X|L2],XS), append(L1,L2,ZS), permutacion(ZS,YS).


reparto(L,1,[L]).
reparto(L,N,[P|LLS]) :- N > 1,  append(P,RESTO,L) ,N1 is N - 1, reparto(RESTO,N1,LLS).

repartoSinVacias(L,1,[L]) :- L \= [].
repartoSinVacias(L,N,[P|LLS]) :- N > 1,   append(P,RESTO,L), P \= [], N1 is N - 1, repartoSinVacias(RESTO,N1,LLS).


%% Ejercicio 8

parteQueSuma(_,0,[]).
parteQueSuma([X|XS],S,[X|ZS]) :-  S1 is S - X, S1 >= 0, parteQueSuma(XS,S1,ZS).
parteQueSuma([_|XS],S,ZS) :-  S \= 0, parteQueSuma(XS,S,ZS).

%% Ejercicio 9 

desde(X,X).
desde(X,Y) :- nonvar(Y), Y > X.
desde(X,Y) :- var(Y), N is X+1, desde(N,Y).

%% Los parametros deben instanciarse como desde(+X,-Y), porque sino Y si esta instanciado al hacer backtracking luego de dar
%% el resultado se queda en un bucle infinito.

%% Ejercicio 10

intercalar([],YS,YS).
intercalar(XS,[],XS).
intercalar([X|XS],[Y|YS],[X,Y|ZS]) :- intercalar(XS,YS,ZS).

%% Ejercicio 11

vacio(nil).

raiz(bin(_,R,_),R).

altura(nil,0).
altura(bin(I,_,D),A) :- altura(I,S1) , altura(D,S2), max(S1,S2,S), A is 1 + S.

max(N1,N2,N1) :- N1 > N2.
max(N1,N2,N2) :- N1 =< N2.

cantNodos(nil,0).
cantNodos(bin(I,_,D),A) :- cantNodos(I,S1) , cantNodos(D,S2),  A is 1 + S1 + S2.

%% Ejercicio 12 

%% i 
inorder(nil,[]).
inorder(bin(I,R,D),ZS) :- inorder(I,ZS1), inorder(D,ZS2), append(ZS1,[R|ZS2],ZS).

%% ii 
arbolConInorder([],nil).
arbolConInorder(LS,bin(I,R,D)) :- 
    append(LI,[R|LD],LS),
    arbolConInorder(LI,I),
    arbolConInorder(LD,D).

%% iii 
abb(nil).
abb(bin(I,R,D)) :- inorder(I,IS), inorder(D,DS), esMayorOigual(R,IS), esMenor(R,DS), abb(I), abb(D).

esMayorOigual(_,[]).
esMayorOigual(X,[Y|YS]) :- X >= Y , esMayorOigual(X,YS).

esMenor(_,[]).
esMenor(X,[Y|YS]) :- X < Y , esMenor(X,YS).

%% iv 

aBBInsertar(X,nil,bin(nil,X,nil)).
aBBInsertar(X,bin(I,R,D),bin(M,R,D)) :- X =< R, aBBInsertar(X,I,M).
aBBInsertar(X,bin(I,R,D),bin(I,R,M)) :- X > R, aBBInsertar(X,D,M).

