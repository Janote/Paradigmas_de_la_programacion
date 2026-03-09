### Funciones conocidas: 

curry :: ((a, b) -> c) -> a -> b -> c
curry f x y = f (x, y)

uncurry :: (a -> b -> c) -> (a, b) -> c
uncurry f (x, y) = f x y


### Recursion Estructural

Sea g :: [a] -> b definida por dos ecuaciones:

```haskell
g [] = ⟨caso base⟩
g (x : xs) = ⟨caso recursivo⟩
```
g esta dada por recursion estructural si:
1. El caso base devuelve un valor z “fijo” (no depende de
g).
2. El caso recursivo no puede usar las variables g ni xs,
salvo en la expresion (g xs).

g [] = z
g (x : xs) = . . . x . . . (g xs) . . .


**Toda recursion estructural es una instancia de foldr.**


```haskell
foldr :: (a -> b -> b) -> b -> [a] -> b
foldr f z [] = z
foldr f z (x : xs) = f x (foldr f z xs)
```


### Recursion primitiva
Sea g :: [a] -> b definida por dos ecuaciones:
```haskell
g [] = z
g (x : xs) = . . . x . . . xs . . . (g xs) . . .
```

Decimos que la definicion de g esta dada por recursion primitiva
si:
1. El caso base devuelve un valor z “fijo” (no depende de g).
2. El caso recursivo no puede usar la variable g, salvo en la
expresion (g xs).

Sı puede usar la variable xs
Similar a la recursion estructural, pero permite referirse a xs.


**Toda recursion primitiva es una instancia de recr.**

recr :: (a -> [a] -> b -> b) -> b -> [a] -> b
recr f z [] = z
recr f z (x : xs) = f x xs (recr f z xs)

### Recursion iterativa

Sea g :: b -> [a] -> b definida por dos ecuaciones:
g ac [] = ⟨caso base⟩
g ac (x : xs) = ⟨caso recursivo⟩

Decimos que la definicion de g esta dada por recursion iterativa si:
1. El caso base devuelve el acumulador ac.
2. El caso recursivo invoca inmediatamente a (g ac’ xs),
donde ac’ es el acumulador actualizado en funcion de su
valor anterior y el valor de x.

```haskell
foldl :: (b -> a -> b) -> b -> [a] -> b
foldl f ac [] = ac
foldl f ac (x : xs) = foldl f (f ac x) xs
```

En general foldr y foldl tienen comportamientos diferentes:
foldr (⋆) z [a, b, c] = a ⋆ (b ⋆ (c ⋆ z))
foldl (⋆) z [a, b, c] = ((z ⋆ a) ⋆ b) ⋆ c
Si (⋆) es un operador asociativo y conmutativo, foldr y foldl
definen la misma funci´on. Por ejemplo:

La funcion foldl es un operador de iteraci´on.
Pseudoc´odigo imperativo:
funcion foldl f ac xs {
mientras xs no es vac´ıa {
ac := f ac (head xs)
xs := tail xs
}
devolver ac
}

###  Tipos de datos algebraicos

data Dia = Dom | Lun | Mar | Mie | Jue | Vie | Sab


### Recursión estructural

La recursión estructural se generaliza a tipos algebraicos en general.  

Supongamos que `T` es un tipo algebraico.

Dada una función `g :: T -> Y` definida por ecuaciones:


g (CBase1 ⟨parámetros⟩) = ⟨caso base1⟩
...
g (CBasen ⟨parámetros⟩) = ⟨caso basen⟩

g (CRecursivo1 ⟨parámetros⟩) = ⟨caso recursivo1⟩
...
g (CRecursivom ⟨parámetros⟩) = ⟨caso recursivom⟩


Decimos que `g` está dada por **recursión estructural** si:

1. Cada caso base se escribe combinando los parámetros.

2. Cada caso recursivo se escribe combinando:

   - Los parámetros del constructor que no son de tipo `T`.
   - El llamado recursivo sobre cada parámetro de tipo `T`.

Pero:

- Sin usar los parámetros del constructor que son de tipo `T`.
- Sin hacer otros llamados recursivos.

### Funciones Utiles:

```haskell
foldr1 :: (a -> a -> a) -> [a] -> a
foldr1 f [x] = x
foldr1 f (x:xs) = f x (foldr1 f xs)
```
