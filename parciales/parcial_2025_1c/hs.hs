import Data.List (nub)

data FS = Arch String | Dir String [FS] deriving (Eq, Show)

foldFS :: (String -> b) -> (String -> [b] -> b) -> FS -> b
foldFS fArch fDir fs = case fs of
  Arch x -> fArch x
  Dir s xs -> fDir s (map rec xs)
  where
    rec = foldFS fArch fDir

recFS :: (String -> b) -> (String -> [b] -> [FS] -> b) -> FS -> b
recFS fArch fDir fs = case fs of
  Arch x -> fArch x
  Dir s xs -> fDir s (map rec xs) xs
  where
    rec = recFS fArch fDir

rutas :: FS -> [String]
rutas = foldFS (\s -> [s]) (\s xs -> s : map ((s ++ "/") :) (concat xs))

valido :: FS -> Bool
valido = recFS (\_ -> True) (\_ xs fs -> length (nub fs) == length (eliminarRepes fs) && all (== True) xs)

eliminarRepes :: [FS] -> [String]
eliminarRepes =
  foldr
    ( \x rec -> case x of
        Arch s -> [s]
        Dir s xs -> [s]
    )
    []

unDir :: FS
unDir =
  Dir
    "raiz"
    [ Arch "arch1",
      Arch "arch2",
      Arch "arch3",
      Dir
        "subdir1"
        [ Arch "arch4"
        ],
      Dir
        "subdir2"
        [ Arch "arch1",
          Arch "arch5"
        ]
    ]