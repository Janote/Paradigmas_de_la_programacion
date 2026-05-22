import Data.List (intersect, nub)

data LineaProd = Materiales [String] | Agregar String LineaProd | Unir LineaProd LineaProd

foldLineaProd :: ([String] -> b) -> (String -> b -> b) -> (b -> b -> b) -> LineaProd -> b
foldLineaProd fMateriales fAgregar fUnir linea = case linea of
  Materiales xs -> fMateriales xs
  Agregar s a -> fAgregar s (rec a)
  Unir a b -> fUnir (rec a) (rec b)
  where
    rec = foldLineaProd fMateriales fAgregar fUnir

recLineaProd :: ([String] -> b) -> (String -> b -> LineaProd -> b) -> (b -> b -> LineaProd -> LineaProd -> b) -> LineaProd -> b
recLineaProd fMateriales fAgregar fUnir linea = case linea of
  Materiales xs -> fMateriales xs
  Agregar s a -> fAgregar s (rec a) a
  Unir a b -> fUnir (rec a) (rec b) a b
  where
    rec = recLineaProd fMateriales fAgregar fUnir

materialesUsados :: LineaProd -> [String]
materialesUsados = foldLineaProd nub (\s rec -> nub (s : rec)) (\ri rd -> nub (ri ++ rd))

mismaEstructura :: LineaProd -> LineaProd -> Bool
mismaEstructura =
  foldLineaProd
    ( \xs est -> case est of
        Materiales ys -> True
        _ -> False
    )
    ( \s l est -> case est of
        Agregar x linea -> l linea
        _ -> False
    )
    ( \ri rd est -> case est of
        Unir i d -> ri i && rd d
        _ -> False
    )

sublineasDisjuntas :: LineaProd -> Bool
sublineasDisjuntas = recLineaProd (const True) (\s rec linea -> rec) (\ri rd i d -> null (intersect (lineaALista i) (lineaALista d)) && ri && rd)

lineaALista :: LineaProd -> [String]
lineaALista = foldLineaProd id (\s rec -> s : rec) (++)

l1 =
  Unir
    (Materiales ["acero", "cobre"])
    (Unir
      (Agregar "madera" (Materiales ["madera"]))
      (Materiales ["mercurio"]))
l2 =
  Unir
    (Materiales ["acero", "cobre"])
    (Unir
      (Agregar "madera" (Materiales ["aluminio"]))
      (Agregar "aluminio" (Materiales ["plástico"])))
l3 =
  Unir
    (Materiales ["m1"])
    (Unir
      (Agregar "m3" (Materiales ["m3", "m4"]))
      (Materiales ["m1", "m2"]))