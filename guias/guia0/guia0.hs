{- HLINT ignore "Use map" -}
import Language.Haskell.TH (Body)
import Debug.Trace
import GHC.Real (infinity)

-- Guia 0 


-- Ejercicio 1
{- 
null :: Foldable t => t a -> Bool : Toma una estructura y nos devuelve un booleano indicando si es vacia o no 

head :: [a] -> a : Devuelve el primer elemento de una lista

init :: [a] -> [a] : Devuelve la lista sin el ultimo elemento.

last :: [a] -> a : Devuelve el ultimo elemento de una lista

take :: [a] -> Int -> [a] : Toma una lista, un numero n y devuelve la lista de los primeros n elementos

drop :: [a] -> Int -> [a] : Toma una lista, un numero n y devuelve la lista sacando los primeros n elementos de la lista original.

(++) : [a] -> [a] -> [a] : Toma dos listas y devuelve la concatenacion de ambas.

concat : Foldable t => t [a] -> [a] : Devuelve la lista sacando los pliegues necesarios dependiendo del tipo de dato a. 

reverse :: [a] -> [a] : Devuelve el reverso de la lista.

elem :: [a] -> a -> Bool : Devuelve un booleano indicando si el elemento pertenece o no a la lista.
-}

-- Ejercicio 2

valorAbsoluto :: Float -> Float
valorAbsoluto x = if x < 0 then -x else x

factorial :: Integer -> Integer
factorial n | n < 0 = error "error, numero negativo"
            | n == 1 || n == 0 =  1
            | otherwise = n * factorial (n - 1)


cantDivisoresPrimos :: Int -> Int
cantDivisoresPrimos 0 = error "infinitos"
cantDivisoresPrimos 1 = 1
cantDivisoresPrimos n = cantDivisoresPrimosAux 2 n

cantDivisoresPrimosAux :: Int -> Int -> Int
cantDivisoresPrimosAux i n
                           | i == n && esPrimo n =  1
                           | i == n && not (esPrimo n) =  0
                           |  n `mod` i == 0 && esPrimo i = 1 + cantDivisoresPrimosAux (i + 1) n
                           | otherwise = cantDivisoresPrimosAux (i+1) n


esPrimo :: Int -> Bool
esPrimo = esPrimoAux 2

esPrimoAux :: Int -> Int -> Bool
esPrimoAux i n | i == n = True
               | otherwise = n `mod` i /= 0 && esPrimoAux (i+1) n

-- Ejercicio 3

inverso :: Float -> Maybe Float
inverso 0 = Nothing
inverso n = Just (1 / n)

aEntero :: Either Int Bool -> Int
aEntero (Right b) = if b then 1 else 0
aEntero (Left a) = a


-- Ejercicio 4 

limpiar :: String -> String -> String
limpiar s1 = foldr (\x rec -> if x `elem` s1 then rec else x : rec) []


difPromedio :: [Float] -> [Float]
difPromedio xs = let prom = sum xs /  fromIntegral (length xs) in foldr (\x rec -> x - prom : rec) [] xs


todosIguales :: [Int] -> Bool
todosIguales (x:xs) = foldr (\y ys -> x == y && ys ) True xs


-- Ejercicio 5 

data AB a = Nil | Bin (AB a) a (AB a)

vacioAB :: AB a -> Bool
vacioAB  Nil = True
vacioAB _ = False

negacionAB :: AB Bool -> AB Bool
negacionAB Nil = Nil
negacionAB (Bin i r d) = Bin (rec i ) (not r) (rec d )
                    where rec = negacionAB

productoAB :: AB Int -> Int
productoAB Nil = 1
productoAB (Bin i r d) = productoAB i * r * productoAB d


