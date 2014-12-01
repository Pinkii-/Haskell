insert :: [Int] -> Int -> [Int]
insert [] n = [n]
insert l@(x:xs) n
    | x > n = n:l
    | otherwise = x:(insert xs n)
    
isort :: [Int] -> [Int]
isort [] = []
isort (x:xs) = (insert (isort xs) x)

remove :: [Int] -> Int -> [Int]
remove [] n = []
remove (x:xs) n
    | x == n = xs
    | otherwise = x:(remove xs n)
    
ssort :: [Int] -> [Int]
ssort [] = []
ssort l = min:ssort(remove l min)
    where min = minimum l
    
merge :: [Int] -> [Int] -> [Int]
merge [] l = l
merge l [] = l
merge l1@(x:xs) l2@(y:ys)
    | x > y = y:(merge l1 ys)
    |otherwise = x:(merge xs l2)
    
msort :: [Int] -> [Int]
msort [] = []
msort [x] = [x]
msort l = merge (msort l1) (msort l2)
    where ll = splitAt (div (length l) 2) l 
          l1 = fst ll
          l2 = snd ll
          
qsort :: [Int] -> [Int]
qsort [] = []
qsort [x] = [x]
qsort (x:xs) = qsort(fst (numb x xs)) ++ [x] ++ qsort(snd (numb x xs))
    where
        numb :: Int -> [Int] -> ([Int],[Int])
        numb _ [] = ([],[])
        numb n (y:ys)
            | y < n = (y:l1,l2)
            | otherwise = (l1,y:l2)
            where (l1,l2) = numb n ys
            
genQsort :: Ord a => [a] -> [a]
genQsort [] = []
genQsort [x] = [x]
genQsort (x:xs) = genQsort(fst (numb x xs)) ++ [x] ++ genQsort(snd (numb x xs))
    where
        numb :: Ord a => a -> [a] -> ([a],[a])
        numb _ [] = ([],[])
        numb n (y:ys)
            | y < n = (y:l1,l2)
            | otherwise = (l1,y:l2)
            where (l1,l2) = numb n ys
