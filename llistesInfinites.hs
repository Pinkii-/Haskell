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

fibs :: [Integer]
<<<<<<< HEAD
fibs = [0,1]++(aFibs 0 1)
    where
        aFibs :: Integer -> Integer -> [Integer]
        aFibs x y = z:(aFibs y z) where z = x + y
=======
fibs = 0 : scanl (+) 1 fibs
>>>>>>> 9a5316821e40b8ba7b53f322f503c666dc4b6a62

fibss = 0 : scanl (+) 1 fibss


--primes :: [Integer]
--primes = p [2]
--    where
--        p :: [Integer] -> [Integer]
--        p l = l++(p (noDivisibles l))
--            where 
--               noDivisibles :: [Integer] -> [Integer]
--                noDivisibles (x:xs)
--
--hacer la funcion que llamandola con un 2 te de todos los unmeros que no son divisibles por ninguno de los anteriores. Utilizar funcion de orden superior.


hammings :: [Integer] -- los hamming numbers son el resultaoo de multiplicar todos los anteriores hamming numbers por 2,3,5. Hacer una sinercion con merge.
hammings = 1:(filter (divisibles) (drop 1 nats))
    where 
        divisibles :: Integer -> Bool
        divisibles n
            | (mod n 2 == 0) = True
            | (mod n 3 == 0) = True
            | (mod n 5 == 0) = True
            | otherwise = False

--hammings = hamg [1]
--hamg :: [Integer] -> [Integer]
--hamg l = merge l (hamg ((map (*2) l)++(map (*3) l))++(map (*5) l))
--merge :: [Integer] -> [Integer] -> [Integer]
--merge [] l = l
--merge l [] = l
--merge l1@(x:xs) l2@(y:ys)
--    | x == y = x:(merge xs ys)
--    | x > y = y:(merge l1 ys)
--    |otherwise = x:(merge xs l2)
             

--lookNsay :: [Integer]

--tartaglia :: [[Integer]]
