## Razonamiento ecuacional e induccion estructural.

### Hipotesis de trabajo

Trabajamos con estructuras de datos finitas, con tipos de datos inductivos.

Trabajamos con funciones totales.


El programa no depende del orden de las ecuaciones.
```haskell
vacia [] = True
vacia _ = False ⇝vacia [] = True
vacia (_ : _) = False
```

Relajar estas hiṕotesis es posible, pero mas complejo.


### Igualdades por definicion 

Sea e1 = e2 una ecuacion del programa. Las siguientes operaciones preservan la igualdad de expresiones:
1. Reemplazar cualquier instancia de e1 por e2.
2. Reemplazar cualquier instancia de e2 por e1


## Induccion estructural

#### Principio de induccion sobre booleanos
- Si P(True) y P(False) entonces ∀x ::Bool.P(x).

#### Principio de induccion sobre pares
- Si ∀x ::a.∀y ::b.P((x, y)) entonces ∀p ::(a, b).P(p)

#### Principio de induccion sobre naturales
- Si P(Zero) y ∀n ::Nat.(P(n)⇒ P(Suc n)), entonces ∀n ::Nat.P(n).


### Induccion estructural
En el caso general, tenemos un tipo de datos inductivo:
data T = CBase1 ⟨parametros⟩
...
| CBasen⟨parametros⟩
| CRecursivo1 ⟨parametros⟩
...
| CRecursivom⟨parametros⟩

#### Principio de induccion estructural
Sea P una propiedad acerca de las expresiones tipo T tal que:
1. P vale sobre todos los constructores base de T,
2. P vale sobre todos los constructores recursivos de T, asumiendo como hipotesis inductiva que vale para los parametros de tipo T, entonces ∀x ::T.P(x).

## Lemas de generación

Usando el **principio de inducción estructural**, se puede probar:

### Lema de generación para pares

Si  
`p :: (a, b)`

entonces:

∃ `x :: a`. ∃ `y :: b`. `p = (x, y)`

---

```haskell
data Either a b = Left a | Right b
```


### Lema de generación para sumas

Si  
`e :: Either a b = Left a | Right b`

entonces:

- o bien ∃ `x :: a`. e = Left x`
- o bien ∃ `y :: b`. e = Right y`

## Extensionalidad

### Principio de extensionalidad funcional
Sean f, g ::a -> b. 

#### Propiedad inmediata
Si f = g entonces (∀x ::a.f x = g x).

#### Principio de extensionalidad funcional
Si (∀x ::a.f x = g x) entonces f = g.


### Isomorfismos de tipos 

#### Decimos que dos tipos de datos A y B son isomorfos si:
1. Hay una funcion f ::A -> B total.
2. Hay una funcion g ::B -> A total.
3. Se puede demostrar que g . f = id ::A -> A.
4. Se puede demostrar que f . g = id ::B -> B.
Escribimos A ≃B para indicar que A y B son isomorfos

## Notas Sueltas
Si la estructura no es recursiva, podes usar induccion o lema de generacion sobre la estructura
