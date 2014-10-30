flatten :: [[Int]] -> [Int]
flatten xs = foldr (\x a -> x++a) [] xs

flatten2 :: [[Int]] -> [Int]
flatten2 xs = foldl (\a x -> a++x) [] xs

myLength :: String -> Int
myLength s = foldr (\x a -> a+1) 0 s

myReverse :: [Int] -> [Int] -- Rapido
myReverse xs = foldl (\a x -> [x]++a) [] xs

myReverse2 :: [Int] -> [Int] -- Lento
myReverse2 xs = foldr (\x a -> a++[x]) [] xs

countIn :: [[Int]] -> Int -> [Int]
countIn xs n = map (count n) xs
    where
        count :: Int -> [Int] -> Int
        count l ys = foldr (sumaSi l) 0 ys
            where
                sumaSi :: Int -> Int -> Int -> Int
                sumaSi l y a
                    | y == l = a + 1
                    | otherwise = a
