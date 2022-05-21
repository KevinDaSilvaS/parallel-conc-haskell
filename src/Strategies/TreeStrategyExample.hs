module Strategies.TreeStrategyExample where

import Control.Parallel.Strategies
import EvalMonad.ParMapExample(comp2)

import Control.Exception
import Data.Time.Clock

compCost x = (comp2 $ comp2 $ comp2 $ comp2 x)

data Tree a = Node a (Tree a) (Tree a) | Empty deriving(Show)

tree = Node (compCost 30) (Node (compCost 25) Empty (Node (compCost 26) Empty Empty)) (Node (compCost 35) (Node (compCost 34) Empty Empty) Empty)

strategyTree :: Strategy a -> Tree a -> Eval (Tree a)
strategyTree _ Empty = return Empty
strategyTree s (Node v l r) = do 
    a' <- s v
    l' <- strategyTree s l
    r' <- strategyTree s r
    return (Node a' l' r')

example = do
    t1 <- getCurrentTime
    let v = tree `using` (strategyTree rpar)
    print v

    t2 <- getCurrentTime

    putStrLn "total time" 
    print $ diffUTCTime t2 t1