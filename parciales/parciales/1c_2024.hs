import Data.Sequence.Internal.Sorting (QList(Nil))
data AT a  = NilT | Tri a (AT a) (AT a) (AT a)

foldAT :: b -> (a -> b -> b -> b -> b) -> AT a -> b
foldAT fNil fTri arbol = case arbol of
    NilT -> fNil
    Tri x i m d -> fTri x (rec i) (rec m) (rec d)
    where rec = foldAT fNil fTri

preorder :: AT a -> [a]
preorder = foldAT [] (\v i m d -> [v] ++ i  ++ m ++ d)

mapAT :: (a -> b) -> AT a -> AT b
mapAT f = foldAT NilT (\v i m d -> Tri (f v) i m d )

nivel :: AT a -> Int -> [a]
nivel = foldAT (const []) (\v ri rm rd n -> if n == 0 then [v] else ri (n - 1) ++ rm (n - 1) ++ rd (n - 1))

