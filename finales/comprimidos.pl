comprimidos([],[]).
comprimidos(L1,CS) :-  L1 = [X | _ ], 
                       armarBloque(X,L1,Bloque),
                       append(Bloque,Resto,L1),
                       comprimidos(Resto,XS),
                       append(Bloque,XS,CS).
comprimidos(L1,CS) :-  L1 = [X | _ ], 
                       armarBloque(X,L1,Bloque),
                       length(Bloque,N),
                       append(Bloque,Resto,L1),
                       comprimidos(Resto, XS),
                       append([c(X,N)],XS,CS).


armarBloque(_,[],[]).
armarBloque(X,[X|XS],[X|CS]) :- armarBloque(X,XS,CS).
armarBloque(X,[Y|XS],CS) :- X \= Y,  armarBloque(X,XS,CS).


iguales(L1,L2) :- descomprimir(L1,XS), descomprimir(L2,YS), XS = YS.

descomprimir([],[]).
descomprimir([c(X,N)|XS],YS) :- length(ZS,N), llenarDeX(X,ZS), descomprimir(XS,RS), append(ZS,RS,YS).
descomprimir([X|XS],[X|YS]) :-  X \= c(_,_), descomprimir(XS,YS).

llenarDeX(_,[]).
llenarDeX(X,[X|XS]) :- llenarDeX(X,XS).


coprimos()