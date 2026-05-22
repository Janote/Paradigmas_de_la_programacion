import Data.List (delete)
import Distribution.TestSuite (Result (Error))

{- HLINT ignore "Use camelCase" -}
data Buffer a = Empty | Write Int a (Buffer a) | Read Int (Buffer a)

{--
"Si escribo 2 veces en la misma posicion, el nuevo contenido pisa al anterior"
"La lectura elimina el contenido leido."

--}
buf = Write 1 "a" $ Write 2 "b" $ Write 1 "c" $ Empty

b1 = Write 2 True Empty

b2 = Write 2 True (Write 2 False Empty)

b3 = Read 1 (Write 2 True (Write 1 False Empty))

foldBuffer :: b -> (Int -> a -> b -> b) -> (Int -> b -> b) -> Buffer a -> b
foldBuffer fEmpty fWrite fRead buf = case buf of
  Empty -> fEmpty
  Write i x sb -> fWrite i x (rec sb)
  Read i sb -> fRead i (rec sb)
  where
    rec = foldBuffer fEmpty fWrite fRead

recBuffer :: b -> (Int -> a -> b -> Buffer a -> b) -> (Int -> b -> Buffer a -> b) -> Buffer a -> b
recBuffer fEmpty fWrite fRead buf = case buf of
  Empty -> fEmpty
  Write i x sb -> fWrite i x (rec sb) sb
  Read i sb -> fRead i (rec sb) sb
  where
    rec = recBuffer fEmpty fWrite fRead

posiciones_ocupadas :: Buffer a -> [Int]
posiciones_ocupadas = recBuffer [] (\num val rec sub -> if otrasEscrituras num sub then rec else num : rec) (\i rec sb -> delete i rec)

otrasEscrituras :: Int -> Buffer a -> Bool
otrasEscrituras x = foldBuffer False (\i _ rec -> i == x || rec) (\i rec -> rec)

contenido :: Int -> Buffer a -> Maybe a
contenido i buffer = if elem i (posiciones_ocupadas buffer) then Just (obtenerEscritura i buffer) else Nothing

obtenerEscritura :: Int -> Buffer a -> a
obtenerEscritura x = foldBuffer (error "mal llamado") (\i v rec -> if i == x then v else rec) (\_ rec -> rec)

puedeCompletarLecturas:: Eq a => Buffer a -> Bool
puedeCompletarLecturas = recBuffer True (\i v rec sub ->  rec) (\i rec sub -> if contenido i sub == Nothing then False else rec)

deshacer::Buffer a -> Int -> Buffer a
deshacer = recBuffer (const Empty) (\i v rec sub n -> if n == 0 then Write i v sub else rec (n-1)) (\i rec sub n -> if n == 0 then Read i sub else rec (n - 1))

