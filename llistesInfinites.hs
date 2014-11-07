ones :: [Integer]
ones = iterate (\x -> 1) 1

nats :: [Integer]
nats = iterate (\x -> x+1) 0

ints :: [Integer]
ints = iterate (\x -> if (x <= 0) then -x+1 else -x) 0

triangulars :: [Integer]
triangulars = drop 1 $ scanl (\acc x -> acc + x) 0 (drop 1 nats)

factorials :: [Integer]
factorials = scanl (\acc x -> acc * x) 1 (drop 1 nats)

--fibs :: [Integer]
--fibs = <

hacer funcion aux

--primes :: [Integer]


hacer la funcion que llamandola con un 2 te de todos los unmeros que no son divisibles por ninguno de los anteriores. Utilizar funcion de orden superior.



hammings :: [Integer] -- los hamming numbers son el resultaoo de multiplicar todos los anteriores hamming numbers por 2,3,5. Hacer una sinercion con merge.
hammings = 1:(filter (divisibles) (drop 1 nats))
    where 
        divisibles :: Integer -> Bool
        divisibles n
            | (mod n 2 == 0) = True
            | (mod n 3 == 0) = True
            | (mod n 5 == 0) = True
            | otherwise = False
             

--lookNsay :: [Integer]

--tartaglia :: [[Integer]]
