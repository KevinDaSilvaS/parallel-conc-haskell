module ParMonad.ParMonadExample where

import EvalMonad.ParMapExample(comp)

import Control.Monad.Par

example = do
    let r = runPar $ do
            i <- new
            j <- new
            fork $ put i (comp 20) 
            fork $ put j (comp 21)
            a <- get i :: Par Int
            b <- get j :: Par Int
            return (a + b)
    print r
    return ()