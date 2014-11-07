countIf :: (Int -> Bool) -> [Int] -> Int
countIf f xs = foldr (\x acc-> (magic f x)+ acc) 0 xs
    where magic :: (Int -> Bool) -> Int -> Int
          magic f n
              | (f n) = 1
              | otherwise = 0
              
pam :: [Int] -> [Int -> Int] -> [[Int]]
--pam xs fs = [[ (f x) | x<-xs] | f<-fs]
pam xs fs = map (\f -> (map f xs)) fs


-- ($a)
pam2 :: [Int] -> [Int -> Int] -> [[Int]]
pam2 xs fs = [[ (f x) | f<-fs] | x<-xs]

filterFoldl :: (Int -> Bool) -> (Int -> Int -> Int) -> Int -> [Int] -> Int
filterFoldl f1 f2 n xs = foldl lleig n xs
    where lleig = (\acc x -> if (f1 x) then (f2 acc x) else acc)

insert :: (Int -> Int -> Bool) -> [Int] -> Int -> [Int]
insert _ [] n = [n]
insert f l@(x:xs) n
    | (f x n) = x:(insert f xs n)
    | otherwise = n:l

insertionSort :: (Int -> Int -> Bool) -> [Int] -> [Int]
insertionSort _ [] = []
insertionSort f (x:xs) = (insert f (insertionSort f xs) x)
