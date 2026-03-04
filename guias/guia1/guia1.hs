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
