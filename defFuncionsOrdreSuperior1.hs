myFoldl :: (a -> b -> a) -> a -> [b] -> a
myFoldl f acc [x] = f acc x
myFoldl f acc (x:xs) = f (myFoldl f acc xs) x

flatten2 :: [[Int]] -> [Int]
flatten2 xs = myFoldl (\a x -> a++x) [] xs

flatten :: [[Int]] -> [Int]
flatten xs = foldl (\a x -> a++x) [] xs

