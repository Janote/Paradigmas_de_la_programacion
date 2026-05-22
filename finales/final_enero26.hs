import Data.List (sort)

data ABBComp a = Nil | Comp [a] | Nodo a (ABBComp a) (ABBComp a) deriving (Show)

foldABBComp :: b -> ([a] -> b) -> (a -> b -> b -> b) -> ABBComp a -> b
foldABBComp fNil fComp fNodo arbol = case arbol of
  Nil -> fNil
  Comp xs -> fComp xs
  Nodo v i d -> fNodo v (rec i) (rec d)
  where
    rec = foldABBComp fNil fComp fNodo

mapABBComp :: (a -> b) -> ABBComp a -> ABBComp b
mapABBComp f = foldABBComp Nil (\xs -> Comp (map f xs)) (\v i d -> Nodo (f v) i d)

recABBComp :: b -> ([a] -> b) -> (a -> b -> b -> ABBComp a -> ABBComp a -> b) -> ABBComp a -> b
recABBComp fNil fComp fNodo arbol = case arbol of
  Nil -> fNil
  Comp xs -> fComp xs
  Nodo v i d -> fNodo v (rec i) (rec d) i d
  where
    rec = recABBComp fNil fComp fNodo

ordenado :: (Ord a) => ABBComp a -> Bool
ordenado = recABBComp True (\xs -> sort xs == xs) (\v ri rd i d -> v < maximum (arbolAlista i ++ arbolAlista d) && ri && rd)

arbolAlista :: ABBComp a -> [a]
arbolAlista = foldABBComp [] id (\v i d -> [v] ++ i ++ d)

iguales :: (Eq a) => (ABBComp a, ABBComp a) -> Bool
iguales (a1, a2) =
  foldABBComp
    ( \arbol ->
        case arbol of
          Nil -> True
          _ -> False
    )
    ( \xs arbol ->
        case arbol of
          Comp ys -> xs == ys
          _ -> False
    )
    ( \v ri rd -> \arbol -> case arbol of
        Nodo val i d -> v == val && ri i && rd d
    )
    a1
    a2

arboluno = Comp [0, 2, 14, 22]

arboldos = Nodo 2 (Nodo 0 Nil Nil) (Comp [14, 22])

arboltres = Nodo 14 (Nodo 2 (Nodo 0 Nil Nil) Nil) (Nodo 22 Nil Nil)

arbolcuatro = Nodo 14 (Nodo 2 (Nodo 4 Nil Nil) Nil) (Nodo 22 Nil Nil)


    