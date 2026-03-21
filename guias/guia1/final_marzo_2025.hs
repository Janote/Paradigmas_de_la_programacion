data AdjAB a = Raiz a [AB a] | Adj [AB a]

data AB a = Nil | Hoja a | Arb a (AB a) (AB a)

foldAdjAB :: (a -> b) -> b -> AdjAB a -> b
foldAdjAB fRaiz fAdj arbol = case arbol of
  Raiz x xs -> fRaiz x (foldAdjAB z xs)
  Adj xs -> fAdj xs

foldAB :: b -> (a -> b) -> (a -> b -> b -> b) -> AB a -> b
foldAB fNil fHoja fArb arbol = case arbol of
  Nil -> fNil
  Hoja x -> fHoja x
  Arb x i d -> fArb x (rec i) (rec d)
  where
    rec = foldAB fNil fHoja fArb

data Indice = I1 | I2 | I3

data AT a = Hojax a | Nodo (Indice -> AT a)

foldAT :: (a -> b) -> ((Indice -> b) -> b) -> AT a -> b 
foldAT fHoja fNodo arbol = case arbol of 
    Hojax x -> fHoja x
    Nodo  f -> fNodo f (rec (f I1))
    where rec = foldAT fHoja fNodo


