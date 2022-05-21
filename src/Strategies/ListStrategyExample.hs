module Strategies.ListStrategyExample where

import EvalMonad.ParMapExample(comp2)
import Control.Parallel.Strategies

import Control.Exception
import Data.Time.Clock

compCost x = (comp2 $ comp2 $ comp2 $ comp2 x)

example = do
    t1 <- getCurrentTime

    --let l = map (\x -> compCost x) [1..128]
    let l = [(compCost 1), (compCost 2), (compCost 3), (compCost 4)]
    let v = l `using` (parList rpar)
    print v

    t2 <- getCurrentTime

    putStrLn "total time" 
    print $ diffUTCTime t2 t1
    
    putStrLn "hello world" 