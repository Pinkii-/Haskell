absValue :: Int -> Int
absValue n = abs n

power :: Int -> Int -> Int
power x p = x ^ p

isPrime :: Int -> Bool
isPrime n = not (n < 2) && (null [y | y<-[2..floor (sqrt (fromIntegral n))], n `mod` y == 0])

slowFib :: Int -> Int
slowFib 0 = 0
slowFib 1 = 1
slowFib n = slowFib (n-1) + slowFib (n-2)

quickFib :: Int -> Int
quickFib = fst qFib
qFib 0 = (0, 1)
qFib x = (b,a+b) where (a,b) = qFib(x-1)
