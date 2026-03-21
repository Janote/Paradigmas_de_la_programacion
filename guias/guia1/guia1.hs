-- Practica N 1

{-
Ejercicio 1

i)
a)

max2 :: Num a => (a,a) -> a
max2 (x, y) | x >= y = x
            | otherwise = y

b)

normaVectorial :: Num a => (a,a) -> Float
normaVectorial (x, y) = sqrt (x^2 + y^2)

c)

subtract :: Num a =>  a -> a -> a
subtract = flip (-)

d)

predecesor :: Num c => c -> c
predecesor = subtract 1

e)

evaluarEnCero :: Num a => (a -> b) -> b
evaluarEnCero = \f -> f 0

f)

dosVeces ::
dosVeces = \f -> f . f

f1 = (a1 -> b1)
f2 = (a2 -> b2 )
f . f = (a2 -> b2) -> b1

(.) :: (b -> c) -> (a -> b) -> a -> c

f1 = (b -> c)
f2 = (a -> b)
a = = b = c

Entonces:

dosVeces ::  a => (a -> a) -> a -> a

g)

flipAll = map flip
map es de la forma : (a -> b) -> [a] -> [b]
flip :: (a -> b -> c) -> b -> a -> c

Renombre:
map es de la forma : (a1 -> b1) -> [a1] -> [b1]
flip :: (a2 -> b2 -> c2) -> b2 -> a2 -> c2

MGU = {a1 = a2 -> b2 -> c2 , b1 = b2 -> a2 -> c2}

Reemplazando esto en flipAll:
flipAll :: [a2 -> b2 -> c2] -> [b2 -> a2 -> c2]

h)

flipRaro = flip1 flip2 (Es solo un renombre)

Voy a "jugar" con la asociatividad a derecha de los tipos.

flip1 :: (a1 -> b1 -> c1) -> b1 -> a1 -> c1

flip2 :: (a2 -> b2 -> c2) -> (b2 -> a2 -> c2)

{ (a1 -> (b1 -> c1)) =? (a2 -> b2 -> c2) -> (b2 -> a2 -> c2))

a1 = a2 -> b2 -> c2 ,

b1 -> c1 =? b2 -> (a2 -> c2)

a1 = a2 -> b2 -> c2, b1 = b2, c1 = (a2 -> c2)

Tonces: flipRaro :: b2 -> (a2 -> b2 -> c2 ) -> a2 -> c2

La currificación (currying) es la idea de transformar una función que recibe varios argumentos a la vez en una cadena de funciones que reciben un argumento cada una.

Las funciones no currificadas son:

max2 :: Num a => (a,a) -> a
normaVectorial :: Floating a => (a,a) -> a

Sus versiones currificadas:

max2 :: Num a => a -> a -> a
max2 x y | x >= y = x
          | otherwise = y

normaVectorial :: Floating a => a -> a -> a
normaVectorial x y = sqrt (x^2 + y^2)

-}

-- Ejercicicio 2

-- i. Defnir la función curry, que dada una función de dos argumentos, devuelve su equivalente currificada
{- HLINT ignore "Use sum" -}
{- HLINT ignore "Use map" -}
{- HLINT ignore "Avoid lambda" -}

xcurry :: ((a, b) -> c) -> a -> b -> c
xcurry f x y = f (x, y)

-- ii
xuncurry :: (a -> b -> c) -> (a, b) -> c
xuncurry = uncurry

-- iii  Me parece que no se podria dejar fijo los tipos.

-- Ejercicio 3

-- i
sumfoldr :: (Num a) => [a] -> a
sumfoldr = sum

elemfoldr :: (Eq a) => [a] -> a -> Bool
elemfoldr xs e = foldr (\x rec -> x == e || rec) False xs

concatfoldr :: [a] -> [a] -> [a]
concatfoldr xs ys = foldr (:) ys xs

filterfoldr :: [a] -> (a -> Bool) -> [a]
filterfoldr xs p = foldr (\x rec -> if p x then x : rec else rec) [] xs

mapFoldr :: [a] -> (a -> b) -> [b]
mapFoldr xs f = map f xs

-- ii

mejorSegun :: (a -> a -> Bool) -> [a] -> a
mejorSegun criterio = foldr1 (\x rec -> if criterio x rec then x else rec)

-- iii

sumasParciales :: (Num a) => [a] -> [a]
sumasParciales = foldr (\x rec -> x : map (x +) rec) []

-- iv

sumaAlt :: (Num a) => [a] -> a
sumaAlt = foldr (-) 0

-- v

sumaAltv2 :: (Num a) => [a] -> a
sumaAltv2 xs = fst (foldl f (0, 1) xs)
  where
    f (ac, signo) x = (ac + signo * x, -signo)

-- Ejercicio 4

-- partes :: [Int] -> [[Int]]
-- partes = foldr (\x rec -> )
-- Ejercicio 5

{--
elementosEnPosicionesPares no es recursion estructural porque accede a su subestructura en el condicional del if (null xs),
por lo que no es estructural.

entrelazar se hace sobre la lista (x:xs), por lo que si bien puede parecer al principio que tambien estamos accediendo a la
subestructura de ella misma, enrealidad es sobre ys, por lo que esta si es con recursion estructural.

-}

entrelazar :: [a] -> [a] -> [a]
entrelazar = foldr (\x rec ys -> if null ys then rec ys else x : head ys : rec (tail ys)) (const [])

{--
Ayudita para cuando hacemos recursion con dos estructuras a la ves:

Mira la definicion de foldr

foldr :: (a -> b -> b) -> b -> [a] -> b
foldr f z [] = z
foldr f z (x : xs) = f x (foldr f z xs)

a es siempre la cabeza de la lista que posta estamos recorriendo. OK

b es el tipo de retorno, y este tipo es arbitrario, por lo que podes elegir el que vos quieras! Hasta una FUNCION

Entonces porque b no toma la otra estructura? (ys).

b queda ([a] -> resultado)
                                                                                                  2nda est
Entonces el tipo del foldr: foldr :: (a -> ([a] -> res) -> ([a] -> res)) -> ([a] -> res) -> [a] -> [a] -> res

Estamos haciendo:

recursion sobre xs
pero el resultado es
una funcion que espera ys

o sea:

entrelazar xs = funcion que espera ys

--}

-- Ejercicio 6

recr :: (a -> [a] -> b -> b) -> b -> [a] -> b
recr _ z [] = z
recr f z (x : xs) = f x xs (recr f z xs)

-- a
sacarUna :: (Eq a) => a -> [a] -> [a]
sacarUna e = recr (\x xs rec -> if e == x then xs else x : rec) []

-- b
{--
Lo malo de usar recursion estructural (foldr) es que no tenemos acceso a la subestructura de la lista, por lo que eso
hace que no podamos obtener informacion en cada paso recursivo de la misma, por ende se suele utilizar recursion estructural
cuando tenemos que hacer proyecciones sin recorrerla completamente.
--}

-- c
insertarOrdenado :: (Ord a) => a -> [a] -> [a]
insertarOrdenado e = recr (\x xs rec -> if e < x then e : x : xs else x : rec) [e]

-- Ejercicio 7

-- i
mapPares :: (a -> b -> c) -> [(a, b)] -> [c]
mapPares f = map (uncurry f)

-- ii
armarPares :: [a] -> [b] -> [(a, b)]
armarPares = foldr (\x rec ys -> if null ys then rec [] else (x, head ys) : rec (tail ys)) (const [])

-- iii

mapDoble :: (a -> b -> c) -> [a] -> [b] -> [c]
mapDoble f = foldr (\x rec ys -> f x (head ys) : rec (tail ys)) (const [])

-- Ejercicio 8

-- i
sumaMat :: [[Int]] -> [[Int]] -> [[Int]]
sumaMat = zipWith sumarFila

sumarFila :: [Int] -> [Int] -> [Int]
sumarFila = zipWith (+)

-- ii TODO

-- trasponer :: [[Int]] -> [[Int]]
-- trasponer = foldr (\x rec -> )

-- Ejercicio 9

foldNat :: b -> (Integer -> b -> b) -> Integer -> b
foldNat cBase cN n = case n of
  0 -> cBase
  n -> cN n (rec (n - 1))
  where
    rec = foldNat cBase cN

potencia :: Integer -> Integer -> Integer
potencia x = foldNat 1 (\y rec -> x * rec)

-- Ejercicio 10

genLista :: a -> (a -> a) -> Integer -> [a]
genLista initial incremento cantidad =
  foldNat
    ( const []
    )
    (\x rec n -> n : rec (incremento n))
    cantidad
    initial

desdeHasta :: Integer -> Integer -> [Integer]
desdeHasta desde = genLista desde (+ 1)

-- Ejercicio 11

data Polinomio a = X | Cte a | Suma (Polinomio a) (Polinomio a) | Prod (Polinomio a) (Polinomio a) deriving (Show)

foldPolinomio :: b -> (a -> b) -> (b -> b -> b) -> (b -> b -> b) -> Polinomio a -> b
foldPolinomio fX fCte fSum fProd poli = case poli of
  X -> fX
  Cte a -> fCte a
  Suma p q -> fSum (rec p) (rec q)
  Prod p q -> fProd (rec p) (rec q)
  where
    rec = foldPolinomio fX fCte fSum fProd

-- Ejercicio 12

data AB a = Nil | Bin (AB a) a (AB a) deriving (Show)

arbolDePrueba :: AB Int
arbolDePrueba = Bin (Bin Nil 1 Nil) 24 (Bin Nil 5 Nil)

-- i

foldAB :: b -> (b -> a -> b -> b) -> AB a -> b
foldAB fNil fBin arbol = case arbol of
  Nil -> fNil
  Bin i r d -> fBin (rec i) r (rec d)
  where
    rec = foldAB fNil fBin

recAB :: b -> (AB a -> AB a -> b -> a -> b -> b) -> AB a -> b
recAB fNil fBin arbol = case arbol of
  Nil -> fNil
  Bin i r d -> fBin i d (rec i) r (rec d)
  where
    rec = recAB fNil fBin

-- ii

esNil :: AB a -> Bool
esNil arbol = case arbol of
  Nil -> True
  _ -> False

altura :: AB a -> Int
altura = foldAB 0 (\ri _ rd -> 1 + max ri rd)

cantNodos :: AB a -> Int
cantNodos = foldAB 0 (\ri _ rd -> if ri == 0 && rd == 0 then 1 else ri + rd)

-- iii

mejorSegún :: (a -> a -> Bool) -> AB a -> a
mejorSegún criterio (Bin i r d) = foldAB r f (Bin i r d)
  where
    f ri r rd = mejorSegun criterio [ri, r, rd]

-- iv
esABB :: (Ord a) => AB a -> Bool
esABB = recAB True (\i d ri r rd -> ri && rd && todosCumplen (r >=) i && todosCumplen (r <) d)

todosCumplen :: (a -> Bool) -> AB a -> Bool
todosCumplen _ Nil = True
todosCumplen criterio (Bin i r d) = foldAB True f (Bin i r d)
  where
    f ri r rd = ri && criterio r && rd

-- v
{-
En el inciso 2 y 3 para todos los ejercicios en ningun momento necesito acceder a la subestructura, por lo que usamos foldAB.

En cambio en el 4, si necesito ir chequeando c/ subarbol, por lo que usamos el enfoque primitivo recAB.

 -}

-- Ejercicio 21 

listasQueSuman :: Int -> [[Int]]
listasQueSuman 0 = [[]]
listasQueSuman n = [x : xs | x <- [1 .. n], xs <- listasQueSuman (n - x)]

todaslasListasFinitas :: [[Int]]
todaslasListasFinitas = [xs | x <- [1 ..], xs <- listasQueSuman x]

-- Ejercicio 22

data AIH a = Hoja a | Binn (AIH a) (AIH a)

alt f g [] = [] 
alt f g (x:xs) = f x : alt g f xs

a g1 g2 f1 f2 xs  = alt g1 g2 . alt f1 f2 xs
