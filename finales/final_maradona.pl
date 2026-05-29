comprimidos([],[]).
comprimidos(L1,[X|XS]) :- L1 \= [] , generarComprension(L1,RS,X), comprimidos(RS,XS).
comprimidos(L1,[X|XS]) :- saltarComprension(L1,RS), comprimidos(L1,XS).


saltarComprension([],[]).
saltarComprension([X|XS],RS) :- saltarXs()


generarComprension([X],[],c(X,1)).
generarComprension([X,X|XS],RS,c(X,N)) :- generarComprension([X|XS],RS,c(X,N1)), N is N1 + 1. 
generarComprension([X,Y|XS],[Y|XS],c(X,1)) :- X \= Y.


Ejercicio 3 (Programación Lógica). A las listas comunes de números enteros (e.g., [8,1,1,1, 10,10,2]) se le
quiere sumar un nuevo tipo de elemento que son los comprimidos (anotados como c(N,K), donde N es el número y
K es la cantidad de repeticiones, con K ≥ 1). Así, podremos generar listas comprimidas, donde se puedan agrupar los
elementos contiguos repetidos, indicando la cantidad de valores iguales por medio un par de valores (obs.: si se comprime
ciertos elementos contiguos, se deben incluir todos ellos, por lo que, por ejemplo, [8,c(1,2),1,10,10,2] no sería una
compresión válida para el caso anterior). No es obligatorio comprimir toda la lista para que esta sea comprimida.
Sólo por nombrar algunas, la lista anterior podría tener distintas versiones comprimidas: [c(8,1),c(1,3),10,10,2],
[8,c(1,3),c(10,2),2], [c(8,1),c(1,3),c(10,2),c(2,1)], y [8,1,1,1,10,10,2].
a) Definir un predicado comprimido(+L1, -L2) que dada una lista L1, L2 es una versión comprimida de L1. No deben
generarse soluciones L2 idénticas más de una vez.
c) Definir un predicado iguales(+L1, +L2), que indique si dos listas son observacionalmente iguales, considerando
que ambas denotan la misma lista de números enteros. Se pueden agregar predicados auxiliares.









iguales(L1,L2) :- descomprimir(L1,XS) , descomprimir(L2,YS) , XS = YS.

descomprimir([],[]).
descomprimir([c(N,K)|XS],YS) :- listadeNK(N,K,ZS), descomprimir(XS,QS), append(ZS,QS,YS).
descomprimir([X|XS],[X|YS]) :- X \= c(_,_), descomprimir(XS,YS).

listadeNK(N,0,[]).
listadeNK(N,K,[N|NS]) :- K1 is K - 1, listadeNK(N,K1,NS).




