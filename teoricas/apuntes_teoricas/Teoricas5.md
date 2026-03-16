# Calculo Lambda
Es un lenguaje de programacion definido de manera rigurosa, solo 2 operaciones:
1. construir funciones
2. aplicarlas

### Calculo-λb

Sintaxis de los tipos τ,σ,ρ,... ::= bool | τ →σ

Suponemos dado un conjunto infinito numerable de variables:
X = {x ,y ,z ,...}

#### Sintaxis de los terminos

M ,N ,P ,... ::= x  | λx : τ.M  | M N  | true  | false  | if M then N else P 

.Asumimos que la aplicaci ́on es asociativa a izquierda:
M N P = (M N ) P ̸= M (N P )

.La abstraccion y el “if” tienen menor precedencia que la aplicacion:
λx : τ.M N = λx : τ.(M N ) ̸= (λx : τ.M ) N

#### Variables libres y ligadas

Una ocurrencia de x est ́a ligada si aparece adentro de una
abstraccion “λx ”. Una ocurrencia de x esta libre si no esta ligada.


Variables libres: Definici ́on formal
fv(x ) def= {x }
fv(true) = fv(false) def= ∅
fv(if M then N else P ) def= fv(M ) ∪fv(N ) ∪fv(P )
fv(M N ) def= fv(M ) ∪fv(N )
fv(λx : τ.M ) def= fv(M ) \{x }


#### α-equivalencia
. Dos terminos M y N que difieren solamente en el nombre de
sus variables ligadas se dicen α-equivalentes (relacion =α)
▶ α-equivalencia es una relacion de equivalencia
▶ Ojo: De aqui en mas haremos abuso de notacion y usaremos
el operador = para denotar las α-equivalencias (ojo).
λx : τ.λy : σ.x = λy : τ.λx : σ.y = λa : τ.λb : σ.a
λx : τ.λy : σ.x ̸= λx : τ.λy : σ.y = λx : τ.λx : σ.x


#### Sistema de tipos: La nocion de “tipabilidad” se formaliza con un sistema deductivo

Juicios de tipado
El sistema de tipos hace afirmaciones sobre juicios de tipado, de la forma: Γ ⊢M: τ

##### Propiedades del sistema de tipos
###### Teorema (Unicidad de tipos)
Si Γ ⊢M : τ y Γ ⊢M : σ son derivables, entonces τ = σ.
###### Teorema (Weakening + Strengthening)
Si Γ ⊢M : τ es derivable y fv(M ) ⊆ dom(Γ ∩Γ′) entonces Γ′ ⊢M : τ es derivable

#### Semantica : La encargada de darle significado a los programas.
Nosotros vamos a usar semantica operacional small-step: ejecucion paso a paso.



###### Semantica operacional small-step
Programas
Un programa es un termino M tipable y cerrado (fv(M ) = ∅):

. El juicio de tipado ⊢ M : τ debe ser derivable para algun τ.

###### Juicios de evaluacion
La semantica operacional hace afirmaciones sobre juicios de evaluacion:
. M→N
donde M y N son programas.

###### Valores
Los valores son los posibles resultados de evaluar programas:
V ::= true |false |λx : τ.M



###### Propiedades de la evaluacion
###### Teorema (Determinismo)
Si M →N1 y M →N2 entonces N1 = N2.

###### Teorema (Preservacion de tipos)
Si ⊢ M : τ y M →N entonces ⊢ N : τ.

###### Teorema (Progreso)
Si ⊢M : τ entonces:
1. O bien M es un valor.
2. O bien existe N tal que M →N .
###### Teorema (Terminacion)
Si ⊢M : τ, entonces no hay una cadena infinita de pasos:
M →M1 →M2 →...

###### Corolario (Canonicidad)
1. Si ⊢M : bool es derivable, entonces la evaluacion de M
termina y el resultado es true o false.
2. Si ⊢M : τ →σ es derivable, entonces la evaluacion de M
termina y el resultado es una abstraccion

###### Forma normal
Una forma normal es un t ́ermino que no puede evaluarse mas (i.e., M tal que no existe N , M → N ).
###### Lema
Todo valor esta en forma normal.
. Pero no toda formal normal es un valor en calculo-λb (e.g., if x then true else false o x y ).

###### Estado de error
. Estado de la evaluacion donde el termino esta en forma normal,pero no es un valor.
. Representa estado en el cual el sistema de runtime en una implementacion real generarıa una excepcion.
. Recordar que un valor es el resultado al que puede evaluar un termino bien-tipado y cerrado.

Para el calculo de expresiones booleanas valen:
###### Lema (Unicidad de formas normales)
Si M ↠ U y M ↠ V con U ,V formas normales, entonces U = V

###### Lema (Terminacion)
Para todo M existe una forma normal N tal que M ↠ N

