import GHC.Exts.Heap (GenClosure (fun))

data ABNV a = Hoja a | Uni a (ABNV a) | Bi (ABNV a) a (ABNV a) deriving (Show)

foldABNV :: (a -> b) -> (a -> b -> b) -> (b -> a -> b -> b) -> ABNV a -> b
foldABNV fHoja fUni fBi arbol = case arbol of
  Hoja x -> fHoja x
  Uni x sarb -> fUni x (rec sarb)
  Bi i v d -> fBi (rec i) v (rec d)
  where
    rec = foldABNV fHoja fUni fBi

recABNV :: (a -> b) -> (a -> b -> ABNV a -> b) -> (b -> a -> b -> ABNV a -> ABNV a -> b) -> ABNV a -> b
recABNV fHoja fUni fBi arbol = case arbol of
  Hoja x -> fHoja x
  Uni x sarb -> fUni x (rec sarb) sarb
  Bi i v d -> fBi (rec i) v (rec d) i d
  where
    rec = recABNV fHoja fUni fBi

elemABNV :: (Eq a) => a -> ABNV a -> Bool
elemABNV e = foldABNV (== e) (\x rec -> x == e || rec) (\ri v rd -> ri || e == v || rd)

reemplazarUno :: (Eq a) => a -> a -> ABNV a -> ABNV a
reemplazarUno x y =
  recABNV
    (\a -> if a == x then Hoja y else Hoja a)
    (\v rec arbol -> if v == x then Uni y arbol else Uni v rec)
    ( \ri v rd i d ->
        if v == x
          then Bi i y d
          else
            if elemABNV x i then Bi ri v d else Bi i v rd
    )

nivel :: ABNV a -> Int -> [a]
nivel = foldABNV (\a i -> if i == 0 then [a] else []) (\v rec i -> if i == 0 then [v] else rec (i - 1)) (\ri v rd i -> if i == 0 then [v] else ri (i - 1) ++ rd (i - 1))

abnv = Bi (Uni 2 (Hoja 1)) 3 (Bi (Hoja 4) 5 (Uni 2 (Hoja 7)))
