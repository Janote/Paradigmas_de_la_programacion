


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


%% Ejercicio 13

coprimos(X,Y) :- desde(1,X), between(1,X,Y), 1 is gcd(X,Y).

%% Ejercicio 14 

%% i 

cuadradoSemiMagico(N,XS) :- desde(0,S), generarMatrizMN(N,N,XS), cadaUnaSumaS(XS,S).

% genera una matriz de M filas por N columnas.
generarMatrizMN(_,0,[]).
generarMatrizMN(M,N,[X|XS]) :-  N > 0, length(X,M), N1 is N - 1 , generarMatrizMN(M,N1,XS).

cadaUnaSumaS([],_).
cadaUnaSumaS([X|XS],S) :- sumaS(X,S), cadaUnaSumaS(XS,S).

sumaS([],0).
sumaS([X|XS],S) :- between(0,S,X), Resto is S - X , sumaS(XS,Resto).

%% ii 
cuadradoMagico(N,XS) :- N > 0 , cuadradoSemiMagico(N,XS), columnasSumanLoMismo(XS).

columnasSumanLoMismo([X|XS]) :- length(X,L), L1 is L - 1, between(0,L1,I), chequearColumnas(I,L1,[X|XS]). 


obtener_columna([], _, []).
obtener_columna([Fila | Resto], I, [Elem | Col]) :-
    nth0(I, Fila, Elem),
    obtener_columna(Resto, I, Col).


esTriangulo(tri(A,B,C)) :-
    A > 0, B > 0, C > 0,
    A+B > C, A+C > B, B+C > A.


perimetro(T,P) :-  \+ var(P), generarTrianguloDePerimetro(T,P).
perimetro(T,P) :-   var(P), desde(3,P), generarTrianguloDePerimetro(T,P).



triangulo(T) :- desde(3,P), generarTrianguloDePerimetro(T,P), esTriangulo(T).


generarTrianguloDePerimetro(tri(A,B,C),P) :- between(1,P,A), Dif is P - A, between(1,Dif,B), C is Dif - B, C > 0, esTriangulo(tri(A,B,C)).


%% Ejercicios de Parcial.
unCorte(L,L1,L2,D) :- append(L1,L2,L), sumlist(L1,S1), sumlist(L2,S2), D is abs(S1-S2).

corteMasParejo(L, L1, L2) :- unCorte(L,L1,L2,D), not((unCorte(L,_,_,D2), D2 < D)).



proximoNumeroPoderoso(X,Y) :- buscarPoderoso(X,Y) , !.

buscarPoderoso(X,Y) :- X1 is X + 1, desde(X1,Y), esPoderoso(Y).


esPoderoso(Y):- \+ (between(1,Y,I),esPrimo(I),0 is Y mod I, \+ (0 is Y mod (I * I))).

esPrimo(2).
esPrimo(X) :- X > 2, X1 is X - 1,  not((between(2,X1,I), 0 is X mod I)).


listaAmelodia([X],X).
listaAmelodia(XS,sec(N,M)) :- XS \= [], append(PF,SF,XS), length(PF,L1), length(SF,L2), L1 > 0 , L2 > 0, listaAmelodia(PF,N),  listaAmelodia(SF,M).

submelodia(sec(M1,M2),sec(M1,M2)).
submelodia(sec(M1,_),R) :- submelodia(M1,R).
submelodia(sec(_,M1),R) :- submelodia(M1,R).

sinSubmelodiasEnComun(M1,M2) :- not((submelodia(M2,S2), submelodia(M1,S2))).

nota(do).
nota(re).


melodia(M) :- desde(1,N), melodiasDeLargoN(N,M).

melodiasDeLargoN(1,M) :- nota(M).
melodiasDeLargoN(N,sec(M1,M2)) :- N > 1, between(1,N,L) , Resto is N - L, Resto > 0, melodiasDeLargoN(L,M1), melodiasDeLargoN(Resto,M2).  


secuenciaRepetida([X|XS],S) :- sublista(S,X), S \= [], esSubsecuenciaDelResto(S,XS).

esSubsecuenciaDelResto(_,[]).
esSubsecuenciaDelResto(S,[X|XS]) :- sublista(S,X), esSubsecuenciaDelResto(S,XS).


secuenciaMaxima(M,S) :- secuenciaRepetida(M,S), length(S,N) , not((secuenciaRepetida(M,S1), length(S1,N1), N1 > N)).


todasLasMatrices(M) :- desde(1,NCOL), between(1,NCOL,MFILAS), generarMatrizMN(MFILAS,NCOL,M).

%% Ejercicio 23

arbol(A) :- desde(0,N), arbolesDeTamanoN(N,A).

arbolesDeTamanoN(0,nil).
arbolesDeTamanoN(N,bin(AI,_,AD)) :- 
    N > 0,
    N1 is N - 1,
    between(0,N1,NI),
    ND is N1 - NI,
    arbolesDeTamanoN(NI,AI),
    arbolesDeTamanoN(ND,AD).


nodosEnA(nil,_).
nodosEnA(bin(I,X,D),XS) :- member(X,XS), nodosEnA(I,XS), nodosEnA(D,XS).

sinRepEnA(A,L) :- arbol(A), nodosEnA(A,L), length(),).


arbolConRepetidos(bin(I,R,_)) :- memberArboles(R,I).
arbolConRepetidos(bin(_,R,D)) :- memberArboles(R,D).
arbolConRepetidos(bin(I,R,_)) :- arbolConRepetidos(I).
arbolConRepetidos(bin(_S,R,D)) :- arbolConRepetidos(D).


memberArboles(R,bin(_,R,_)).
memberArboles(R,bin(I,N,_)) :- N \= R, memberArboles(R,I).
memberArboles(R,bin(_,N,D)) :- N \= R, memberArboles(R,D).



