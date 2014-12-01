macu :: [Char] -> Bool
macu nom
    | last nom == 'a'|| last nom == 'A' = False
    | otherwise = True

mace :: Bool -> String
mace True = "Hola maco!"
mace _ = "Hola maca!"

main = do
    nom <- getLine
    putStrLn (mace(macu nom))
