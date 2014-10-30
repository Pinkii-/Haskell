myFoldl :: (a -> b -> a) -> a -> [b] -> a
myFoldl f acc [] = acc
myFoldl f acc (x:xs) = myFoldl f (f acc x) xs

flatten2 :: [[Int]] -> [Int]
flatten2 xs = myFoldl (\a x -> a++x) [] xs

flatten :: [[Int]] -> [Int]
flatten xs = foldl (\a x -> a++x) [] xs

