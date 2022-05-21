{-# LANGUAGE FlexibleContexts #-}
module Strategies.StrategyExample where

import Control.Parallel.Strategies
import EvalMonad.ParMapExample(comp2)
import Data.Time.Clock
import Data.Tuple(swap)

comp x = comp2 $ comp2 $ comp2 x

--par pair
example = do
    t1 <- getCurrentTime
    --let pair = (comp 300, comp 400) `using` parTuple2 rpar rpar 
    let pair = (comp 300, comp 400) `using` parTuple2 rseq rseq 
    print $ swap pair

    t2 <- getCurrentTime
    putStrLn "total time" 
    print $ diffUTCTime t2 t1
