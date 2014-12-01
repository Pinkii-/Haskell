tt8 = Node 8 Empty Empty
tt7 = Node 7 Empty tt8
tt6 = Node 6 Empty Empty
tt5 = Node 5 Empty Empty
tt4 = Node 4 Empty Empty
tt3 = Node 3 tt6 tt7
tt2 = Node 2 tt4 tt5
tt1 = Node 1 tt2 tt3
tt1' = Node 1 tt3 tt2

ii3 = Node 1 Empty Empty
ii2 = Node 1 ii3 Empty
ii1 = Node 1 ii2 Empty
ii0 = Node 1 ii1 Empty


data Tree a = Node a (Tree a) (Tree a) | Empty deriving (Show)

size :: Tree a -> Int
size Empty = 0
size (Node _ t1 t2) = 1 + (size t1) + (size t2)

height :: Tree a -> Int
height Empty = 0
height (Node _ t1 t2) = 1 + max (height t1) (height t2)

equal :: Eq a => Tree a -> Tree a -> Bool
equal Empty Empty = True
equal (Node _ _ _) Empty = False
equal Empty (Node _ _ _) = False
equal (Node a t1 t2) (Node b y1 y2)
    | a /= b = False
    | otherwise = (equal t1 y1) && (equal t2 y2)

isomorphic :: Eq a => Tree a -> Tree a -> Bool
isomorphic Empty Empty = True
isomorphic (Node _ _ _) Empty = False
isomorphic Empty (Node _ _ _) = False
isomorphic (Node a t1 t2) (Node b y1 y2) = sinRotar || rotado
    where sinRotar = (isomorphic t1 y1) && (isomorphic t2 y2)
          rotado   = (isomorphic t1 y2) && (isomorphic t2 y1)

preOrder :: Tree a -> [a]
preOrder Empty = []
preOrder (Node n t1 t2) = n:(preOrder t1)++(preOrder t2)

postOrder :: Tree a -> [a]
postOrder Empty = []
postOrder (Node n t1 t2) = (postOrder t1)++(postOrder t2)++[n]

inOrder :: Tree a -> [a]
inOrder Empty = []
inOrder (Node n t1 t2) = (inOrder t1)++[n]++(inOrder t2)

breadthFirst :: Tree a -> [a]
breadthFirst a = test [a]
    where
        test :: [Tree a] -> [a]
        test [] = []
        test (Abuit:xs) = test xs
        test ((Node n t1 t2):xs) = n:(test(xs++[t1,t2]))
 

