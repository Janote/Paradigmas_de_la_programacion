progenitor (diego, dalma).
progenitor(diego,gianinna).
progenitor(tota,diego).
progenitor(chitoro, ana).
progenitor (ana,daniel).
pareja(gianinna, osvaldo).
pareja(chitoro, tota). pareja(diego, claudia).
pareja(ana, pedro).
pareja(X,Y) :- pareja(Y,X).
ancestro(A, X) :- progenitor (A, X).
ancestro (A, X) :- progenitor(A, Y), ancestro(Y, x).


