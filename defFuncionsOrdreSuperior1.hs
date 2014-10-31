myFoldl :: (a -> b -> a) -> a -> [b] -> a
myFoldl f acc [] = acc
myFoldl f acc (x:xs) = myFoldl f (f acc x) xs

myFoldr :: (a -> b -> b) -> b -> [a] -> b
myFoldr f acc [] = acc
myFoldr f acc (x:xs) = f x (myFoldr f acc xs)

myIterate :: (a -> a) -> a -> [a]
myIterate f a = a:(myIterate f (f a))

myUntil :: (a -> Bool) -> (a -> a) -> a -> a
myUntil fb fa a
    | (fb(fa a)) = fa a
    | otherwise  = myUntil fb fa (fa a)

myMap :: (a -> b) -> [a] -> [b]
myMap f [] = []
myMap f (x:xs) = (f x):(myMap f xs)

myFilter :: (a -> Bool) -> [a] -> [a]
myFilter f [] = []
myFilter f (x:xs)
    | (f x) = x:(myFilter f xs)
    | otherwise = myFilter f xs

myAll :: (a -> Bool) -> [a] -> Bool
myAll f [] = True
myAll f (x:xs)
    | (f x) = myAll f xs
    | otherwise = False

myAny :: (a -> Bool) -> [a] -> Bool
myAny f [] = False
myAny f (x:xs) 
    | (f x) = True
    | otherwise = myAny f xs

myZip :: [a] -> [b] -> [(a,b)]
myZip [] _ = []
myZip _ [] = []
myZip (x:xs) (y:ys) = (x,y):(myZip xs ys)

myZipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
myZipWith f [] _ = []
myZipWith f _ [] = []
myZipWith f (x:xs) (y:ys) = (f x y):(myZipWith f xs ys)

--myZipWith f xs ys = foldr (f (fst z) (snd z)) [] zs
--    where (z:zs) = zip xs ys
