module StrategyExample where

import Control.Parallel.Strategies
import ParMapExample(comp2)
import Data.Time.Clock
import Data.Tuple(swap)

comp x = comp2 . comp2 . comp2 x

{- parMap :: Strategy [a]
parMap (x:xs)= do
    x'  <- rpar x
    xs' <- parMap xs
    return (x':xs') -}

{- parPair :: Strategy [a]
parPair (x, y)= do
    x'  <- rpar x
    y'  <- rpar y
    return (x':y') -}

parPairExample = do
    t1 <- getCurrentTime
    let pair = parPair (comp 10, comp 11)
    print $ swap pair

    t2 <- getCurrentTime
    putStrLn "total time" 
    print $ diffUTCTime t2 t1
