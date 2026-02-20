# Fundamentos de Programación Funcional

## ¿Qué es programación funcional?

La programación funcional consiste en:

> Definir funciones y aplicarlas para procesar información.

### Características principales

-   No hay efectos secundarios.
-   A una misma entrada corresponde siempre la misma salida.
-   Las estructuras de datos son inmutables.
-   Las funciones son datos:
    -   Se pueden pasar como parámetros.
    -   Se pueden devolver como resultados.
    -   Pueden formar parte de estructuras de datos.

------------------------------------------------------------------------

# Expresiones

Una expresión representa datos, funciones o aplicaciones.

## Una expresión puede ser:

### 1. Un constructor

``` haskell
True
False
[]
(:)
0
1
```

### 2. Una variable

``` haskell
x
xs
longitud
(+)
```

### 3. Aplicación

``` haskell
f x
not True
(+) 1
((+) 1) 5
```

⚠ La aplicación es asociativa a izquierda:

    f x y ≡ (f x) y
    f a b c ≡ (((f a) b) c)

------------------------------------------------------------------------

# Tipos

Un tipo especifica el invariante de un dato o función.

Ejemplos:

``` haskell
99 :: Int
not :: Bool -> Bool
(+) :: Int -> Int -> Int
```

El tipo expresa el contrato de la función.

------------------------------------------------------------------------

# Condiciones de tipado

Para que un programa esté bien tipado:

1.  Toda expresión debe tener tipo.
2.  Cada variable se usa siempre con el mismo tipo.
3.  Ambos lados de una ecuación deben tener el mismo tipo.
4.  El argumento debe coincidir con el dominio.
5.  El resultado debe coincidir con el codominio.

Solo tienen sentido los programas bien tipados.

------------------------------------------------------------------------

# Asociatividad del tipo función

El operador `->` es asociativo a derecha:

    a -> b -> c ≡ a -> (b -> c)

Ejemplo:

``` haskell
suma4 :: Int -> Int -> Int -> Int -> Int
```

Se interpreta como:

    Int -> (Int -> (Int -> (Int -> Int)))

Es decir, una función que devuelve otra función (currificación).

------------------------------------------------------------------------

# Polimorfismo

Algunas funciones pueden tener múltiples tipos.

Se usan variables de tipo:

``` haskell
id :: a -> a
[] :: [a]
(:) :: a -> [a] -> [a]
fst :: (a, b) -> a
snd :: (a, b) -> b
```

`a`, `b`, `c` representan tipos desconocidos.

------------------------------------------------------------------------

# Modelo de cómputo

Un programa funcional es un conjunto de ecuaciones orientadas.

Evaluar una expresión consiste en:

1.  Buscar la subexpresión más externa que coincida con el lado
    izquierdo.
2.  Reemplazarla por el lado derecho.
3.  Repetir hasta llegar a:
    -   Un constructor
    -   Una función parcialmente aplicada
    -   Un error (⊥)

------------------------------------------------------------------------

# Funciones de orden superior

Funciones que reciben funciones como parámetros o devuelven funciones.

Ejemplo:

``` haskell
(.) :: (b -> c) -> (a -> b) -> a -> c
(g . f) x = g (f x)
```

Funciones importantes:

``` haskell
map :: (a -> b) -> [a] -> [b]
filter :: (a -> Bool) -> [a] -> [a]
```