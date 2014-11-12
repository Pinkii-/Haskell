-- String -> Identificador per construir objectes
-- Int -> Nombre de arguments que reben
type Signature = [(String,Int)]

-- Int -> Posicio dins de lobjecte
type Position = [Int]

-- Primer element -> una variable
-- Segon element -> terme pel cual substituim
type Substitution a = [(a,a)]

class Rewrite a where
    getVars :: a -> [a] -- [a] son les variables que apareixen a l'objecte rebut.
    valid :: Signature -> a -> Bool --Indica si l'objecte esta construir correctament seguir la signatura
    match :: a -> a -> [(Position,Substitution a)] -- indica en quines posicions del segon objecte el primer fa matching amb la corresponent substitucio. Es a dir, que aplicant la substitucio al primer tenim exactament els subobjectes que esta a la posicio
    apply :: a -> Substitution a -> a -- retorna el objecte resultat de substituir les variables pels objectes de la substitucio
    replace :: a -> [(Position,a)] -> a -- retorna el resultat de canviar cada subobjecte del primer parametre en una de les posicions donades per l'objecte que l'acompanya. No hi ha solapament.
    evaluate :: a -> a -- retorna el resultat d'haver avaluat l'objecte segons alguns simbols predefinits, que no es tracten amb regles de reescritura


data Rule a = Rule a a

instance (Show a) => Show (Rule a) where
    show(Rule a b)= show a ++ " -> " ++ show b

type RewriteSystem a = [Rule a]

validRule :: Rewrite a => Signature -> Rule a -> Bool

validRewriteSystem :: Rewrite a => Signature -> RewriteSystem a -> Bool

--las de mas abajo :> todas las que su camino no es prefijo de otro

--takeWhile dropWhile

--[entran]-> (arbre,[sobran])
