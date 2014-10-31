countIf :: (Int -> Bool) -> [Int] -> Int
countIf f xs = foldr (\x acc-> (magic f x)+ acc) 0 xs
    where magic :: (Int -> Bool) -> Int -> Int
          magic f n
              | (f n) = 1
              | otherwise = 0
              
pam :: [Int] -> [Int -> Int] -> [[Int]]
pam [] _ = []
pam xs fs = (foldr (foldr (\x a -> x) fs) [] xs)
