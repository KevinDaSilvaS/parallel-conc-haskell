module ParPairExample where

import ParMapExample(comp2)

import Control.Parallel.Strategies

import Control.Exception
import Data.Time.Clock

parpair f (x,y) = do
      x' <- rpar (f x)
      y' <- rpar (f y)
      return (x',y')

sincpair f (x,y) = (f x, f y)

example = do
    t1 <- getCurrentTime

    let v = runEval $ parpair (comp2 . comp2 . comp2) (30,40)
    --let v = sincpair (comp2 . comp2 . comp2) (30,40)
    print v

    t2 <- getCurrentTime

    putStrLn "total time" 
    print $ diffUTCTime t2 t1
    
    putStrLn "hello world" 