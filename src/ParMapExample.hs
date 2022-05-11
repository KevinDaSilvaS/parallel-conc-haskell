module ParMapExample where

import Control.Parallel.Strategies

import Control.Exception
import Data.Time.Clock

parmap _ []     = return []
parmap f (x:xs) = do
      x'  <- rpar (f x)
      xs' <- parmap f xs
      return (x':xs')

comp x = x*2*2*3*4*5*6*7*8*2

comp2 x = head $ map (comp . comp . comp . comp . comp . comp . comp . comp . comp . comp . comp . comp) [x]
      
example = do
    t1 <- getCurrentTime

    let v = runEval $ parmap (comp2 . comp2 . comp2) [1..128]
    --let v = map (comp2 . comp2 . comp2) [1..128]
    print $ length (filter even v)

    t2 <- getCurrentTime

    putStrLn "total time" 
    print $ diffUTCTime t2 t1
    
    putStrLn "hello world" 