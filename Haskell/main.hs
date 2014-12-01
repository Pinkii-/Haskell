imc :: Double -> Double -> Double
imc m h = m / h^2

parser :: String -> String
parser entrada =  unlines (wwords (lines entrada))

wwords :: [String] -> [String]
wwords entrada = map unwords (map words entrada)
--(unwords (imc (tail (map words 

main = do
    nom <- getContents
    putStrLn $ parser nom
