eql :: [Int] -> [Int] -> Bool
eql l1 l2 = l1 == l2
--eql [] [] = True
--eql l1 [] = False
--eql [] l2 = False
--eql l1@(x:xs) l2@(y:ys)
--    | x == y = eql xs ys
--    | otherwise = False

prod :: [Int] -> Int
prod [] = 1
prod xs = foldl (\x a -> a*x) 1 xs

prodOfEvens :: [Int] -> Int
prodOfEvens xs = prod (filter even xs)

powersOf2 :: [Int]
powersOf2 = iterate (*2) 1

scalarProduct :: [Float] -> [Float] -> Float
scalarProduct [] [] = 0
scalarProduct xs ys = sum (zipWith (\x y -> x*y) xs ys)
