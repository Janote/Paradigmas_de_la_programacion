data Indice = I1 | I2 | I3 deriving (Show, Eq)

data AT a = Hoja a | Nodo (Indice -> AT a)

instance (Show a) => Show (AT a) where
  show (Hoja x) = "Hoja " ++ show x
  show (Nodo f) =
    "Nodo { I1 = "
      ++ show (f I1)
      ++ ", I2 = "
      ++ show (f I2)
      ++ ", I3 = "
      ++ show (f I3)
      ++ " }"

foldAT :: (a -> b) -> ((Indice -> b) -> b) -> AT a -> b
foldAT fHoja fNodo arbol = case arbol of
  Hoja x -> fHoja x
  Nodo y -> fNodo (\i -> rec (y i))
  where
    rec = foldAT fHoja fNodo

altura :: (Num b, Ord b) => AT a -> b
altura = foldAT (const 1) (\f -> 1 + max (f I1) (max (f I2) (f I3)))

mapAT :: (a -> b) -> AT a -> AT b
mapAT f = foldAT (\x -> Hoja (f x)) (\f -> Nodo f)

arbol :: AT Int
arbol =
  Nodo
    ( \i -> case i of
        I1 -> Hoja 10
        I2 ->
          Nodo
            ( \j -> case j of
                I1 -> Hoja 20
                I2 -> Hoja 30
                I3 -> Hoja 40
            )
        I3 ->
          Nodo
            ( \j -> case j of
                I1 -> Hoja 50
                I2 ->
                  Nodo
                    ( \k -> case k of
                        I1 -> Hoja 60
                        I2 -> Hoja 70
                        I3 -> Hoja 80
                    )
                I3 -> Hoja 90
            )
    )