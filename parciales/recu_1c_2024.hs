-- Me comi el or xd 


import Data.List (nub)

data Prop = Var String | No Prop | Y Prop Prop | Imp Prop Prop

type Valuacion = String -> Bool

foldProp :: (String -> b) -> (b -> b) -> (b -> b -> b) -> (b -> b -> b) -> Prop -> b
foldProp fVar fNo fY fImp prop = case prop of
  Var s -> fVar s
  No p -> fNo (rec p)
  Y p q -> fY (rec p) (rec q)
  Imp p q -> fImp (rec p) (rec q)
  where
    rec = foldProp fVar fNo fY fImp

recProp :: (String -> b) -> (b -> Prop -> b) -> (b -> b -> Prop -> Prop -> b) -> (b -> b -> Prop -> Prop -> b) -> Prop -> b
recProp fVar fNo fY fImp prop = case prop of
  Var s -> fVar s
  No p -> fNo (rec p) p
  Y p q -> fY (rec p) (rec q) p q
  Imp p q -> fImp (rec p) (rec q) p q
  where
    rec = recProp fVar fNo fY fImp

variables :: Prop -> [String]
variables = foldProp ((: [])) id (\ri rd -> nub (ri ++ rd)) (\ri rd -> nub (ri ++ rd))

evaluar :: Valuacion -> Prop -> Bool
evaluar f = foldProp f not (&&) (\ri rd -> not ri || rd)

estaEnFnn :: Prop -> Bool
estaEnFnn = recProp (const True) (\rec sub -> not (esCompleja sub)) (\ri rd i d -> ri && rd) (\ri rd i d -> False)

esCompleja :: Prop -> Bool
esCompleja = foldProp (const False) id (\_ _ -> True) (\_ _ -> True)

