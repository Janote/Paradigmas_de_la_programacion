nota(do).
nota(re).
nota(mi).
nota(fa).
nota(sol).
nota(la).
nota(si).


listaAMelodia([X],X) :- nota(X).
listaAMelodia(XS,sec(M1,M2)) :-  XS \= [], append(YS,ZS,XS), length(YS,N1), length(ZS,N2), listaAMelodia(YS,M1), listaAMelodia(ZS,M2).


submelodia(M,M) :- \+ (nota(M)).
submelodia(sec(M1,_),S) :- submelodia(M1,S).
submelodia(sec(_,M2),S) :- submelodia(M2,S).

