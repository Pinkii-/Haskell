myLength :: [Int] -> Int
myLength [] = 0;
myLength (x:xs) = 1 + myLength xs 

myMaximum :: [Int] -> Int
myMaximum [x] = x;
myMaximum (x:xs)
    | x > max = x
    | otherwise = max
    where max = myMaximum xs

mySum :: [Int] -> Int
mySum [] = 0;
mySum (x:xs) = x + (mySum xs)

average :: [Int] -> Float
average n = fromIntegral((mySum n))/fromIntegral((myLength n))

inv2 :: [Int] -> [Int] ->  [Int]
inv2 [] l2 = l2
inv2 (x:xs) l2 = inv2 xs [x]++l2

buildPalindrome :: [Int] -> [Int]
buildPalindrome l = inv2 l l

isHere :: Int -> [Int] -> Bool
isHere n [] = False
isHere n (x:xs) 
    | x == n = True
    | otherwise = isHere n (xs)

remove :: [Int] -> [Int] -> [Int]
remove [] l = []
remove (x:xs) l2
    | (isHere x l2) = remove xs l2
    | otherwise = x:(remove xs l2)

flatten :: [[Int]] -> [Int]
flatten [] = []
flatten (x:xs) = x++(flatten xs)

oddsNevens :: [Int] -> ([Int],[Int])
oddsNevens [] = ([],[])
oddsNevens (x:xs)
    | even x = (l1,x:l2)
    | otherwise = (x:l1,l2)
    where (l1,l2) = oddsNevens(xs)
    


primeDivisors :: Int -> [Int]
primeDivisors 1 = []
primeDivisors n
    | primes == [] = [n]
    | otherwise = primes++primeDivisors (pene n (head primes))
    where 
    primes = take 1 $ [y | y<-[2..floor (sqrt (fromIntegral n))], n `mod` y == 0]
    pene :: Int -> Int -> Int
    pene n y
        | mod n y == 0 = pene (div n y) y
        | otherwise = n
        
