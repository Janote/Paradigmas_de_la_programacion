data Dato a b = C1 | C2 a | C3 b (Dato a b) (Dato a b)

recDato :: c -> (a -> c) -> (b -> c -> c -> Dato a b -> Dato a b -> c) -> Dato a b -> c
recDato fC1 fC2 fC3 dato = case dato of
  C1 -> fC1
  C2 a -> fC2 a
  C3 b i d -> fC3 b (rec i) (rec d) i d
  where
    rec = recDato fC1 fC2 fC3

foldDato :: c -> (a -> c) -> (b -> c -> c -> c) -> Dato a b -> c
foldDato fC1 fC2 fC3 = recDato fC1 fC2 (\v ri rd _ _ -> fC3 v ri rd)

fSplit :: Dato a b -> ([a],[b])
fSplit = recDato ([],[]) (\v -> ([v],[])) (\b ri rd i d -> (obtenerAes i ++ obtenerAes d , [b] ++ obtenerBes i ++ obtenerBes d ))

obtenerAes :: Dato a b -> [a]
obtenerAes = foldDato [] ((\v -> [v])) (\_ i d -> i ++ d)

obtenerBes :: Dato a b -> [b]
obtenerBes = foldDato [] (const []) (\v i d -> [v] ++ i ++ d)

foldu :: b -> (b -> b -> b) -> [(b -> b)] -> b 
foldu z f [] = z 
foldu z f (x:xs) = f (x (foldu z f xs)) (foldu z f xs)

foldrdos :: b -> (a -> b -> b) -> [a] -> b 
foldrdos fEmpty f  xs = foldu fEmpty const (map f xs)



foldu2 :: b -> (b -> b -> b) -> [(b -> b)] -> b 
foldu2 z f = foldr (\x rec -> f (x rec) rec ) z 
