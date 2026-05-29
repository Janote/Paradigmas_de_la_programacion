existeRefutacionSLD :: [ClausulaDeDefinicion] -> ClausulaObjetivo -> Bool
existeRefutacionSLD xs objetivo | esVacia objetivo = True 
existeRefutacionSLD (x:xs) objetivo | otherwise = existeRefutacionSLD xs (resolvente objetivo x ) || existeRefutacionSLD (xs ++ [x]) objetivo

