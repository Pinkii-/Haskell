linia :: [String] -> String
linia l = (head l)++": "++(imcStr $ tail l)

imcStr :: [String] -> String
imcStr l = traductor (imc (read(head l)::Double) (read(last l)::Double))

imc :: Double -> Double -> Double
imc m h = m / h^2

traductor :: Double -> String
traductor imc
    | imc < 18 = "magror"
    | imc <= 25 = "corpulencia normal"
    | imc <= 30 = "sobrepes"
    | imc <= 40 = "obesitat"
    | otherwise = "obesitat morbida"

parser :: String -> String
parser entrada =  unlines $ palabras $ init $ lines entrada

palabras :: [String] -> [String]
palabras entrada = map linia $ map words entrada
--(unwords (imc (tail (map words 

main = do
    nom <- getContents
    putStr $ parser nom
