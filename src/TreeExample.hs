module TreeExample where

import ParMapExample(comp2)

import Control.Parallel.Strategies
    
import Control.Exception
import Data.Time.Clock

data Tree a = Node a (Tree a) (Tree a) | Empty deriving(Show)

partree f Empty = return Empty
partree f (Node a l r) = do
    a' <- rpar (f a)
    l' <- partree f l
    r' <- partree f r
    return (Node a' l' r')

synctree f Empty = Empty
synctree f (Node a l r) = Node (f a) (synctree f l) (synctree f r)

example = do
    t1 <- getCurrentTime

    let t = (Node 30 (Node 12 Empty (Node 25 Empty Empty)) (Node 46 (Node 45 Empty Empty) Empty))
    let v = runEval $ partree (comp2 . comp2 . comp2) t
    --let v = synctree (comp2 . comp2 . comp2) t
    print v

    t2 <- getCurrentTime

    putStrLn "total time" 
    print $ diffUTCTime t2 t1
    
    putStrLn "hello world" 