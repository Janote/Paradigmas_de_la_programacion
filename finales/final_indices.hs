import Data.List (sort)

-- data Indice = I1 | I2 | I3
-- data AT a = Hoja a | Nodo (Indice -> AT a)

-- foldAt :: (a -> b) -> ((Indice -> b) -> b) -> AT a -> b
-- foldAt fHoja fNodo arbol = case arbol of
--     Hoja v -> fHoja v
--     Nodo f -> fNodo (\v -> rec (f v))
--     where rec = foldAt fHoja fNodo

-- recEst :: (a -> b) -> ((Indice -> b) -> b) -> AT a -> b
-- recEst fHoja fNodo (Hoja x) = fHoja x
-- recEst fHoja fNodo (Nodo f ) = fNodo (\v -> recEst fHoja fNodo (f v))

-- arbol :: AT Int
-- arbol = Nodo (\i -> case i of
--     I1 -> Hoja 3
--     I2 -> Hoja 6
--     I3 -> Hoja 7
--     )

-- suma :: AT Int -> Int
-- suma = foldAt id (\f ->  f I1 + f I2 + f I3)

-- altura :: AT Int -> Int
-- altura = foldAt (const 1) (\f -> 1 + maximum(maximum(f I1, f I2 ), f I3 ))

data ABBComp a = Nil | Comp [a] | Nodo a (ABBComp a) (ABBComp a)

foldABBComp :: b -> ([a] -> b) -> (a -> b -> b -> b) -> ABBComp a -> b
foldABBComp fNil fComp fNodo arbol = case arbol of
  Nil -> fNil
  Comp xs -> fComp xs
  Nodo v i d -> fNodo v (rec i) (rec d)
  where
    rec = foldABBComp fNil fComp fNodo

mapABBComp :: (a -> b) -> ABBComp a -> ABBComp b
mapABBComp f = foldABBComp Nil (Comp . map f) (Nodo . f)

recABBComp :: b -> ([a] -> b) -> (a -> b -> b -> ABBComp a -> ABBComp a -> b) -> ABBComp a -> b
recABBComp fNil fComp fNodo arbol = case arbol of
  Nil -> fNil
  Comp xs -> fComp xs
  Nodo v i d -> fNodo v (rec i) (rec d) i d
  where
    rec = recABBComp fNil fComp fNodo

ordenado :: (Ord a) => ABBComp a -> Bool
ordenado = recABBComp True (\xs -> sort xs == xs) (\v ri rd i d -> todosMenores v i && todosMayores v d && ri && rd)

todosMenores :: (Ord a) => a -> ABBComp a -> Bool
todosMenores v = foldABBComp True (all (v >=)) (\x ri rd -> v >= x && ri && rd)

todosMayores :: (Ord a) => a -> ABBComp a -> Bool
todosMayores v = foldABBComp True (all (v <)) (\x ri rd -> v < x && ri && rd)

inorder :: ABBComp a -> [a]
inorder =
  foldABBComp
    []
    id
    (\v ri rd -> ri ++ [v] ++ rd)

iguales :: (Eq a) => (ABBComp a, ABBComp a) -> Bool
iguales (a1, a2) =
  inorder a1 == inorder a2


data Tren = Locomotora | Carga Tren | Pasajeros Int Tren 

foldTren :: b -> (b -> b) -> (Int -> b -> b) -> Tren -> b 
foldTren fLoc fCarga fPasajeros tren = case tren of 
    Locomotora -> fLoc
    Carga r -> fCarga (rec r)
    Pasajeros n r -> fPasajeros n (rec r)
    where rec = foldTren fLoc fCarga fPasajeros

capacidadTotal :: Tren -> Int
capacidadTotal = foldTren 0 id (+)

todosLosTrenesDePasajeros :: [Tren]
todosLosTrenesDePasajeros = [ tren | x <- [0..], tren <- trenesConXCapacidad x  ]

trenesConXCapacidad :: Int -> [Tren]
trenesConXCapacidad = foldI
    