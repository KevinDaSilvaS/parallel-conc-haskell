module Concurrent.MVars where

import Control.Concurrent
import Control.Monad
import System.IO

example = do
    mvar <- newEmptyMVar
    forkIO $ consumeLogs mvar
    produceLogs mvar
  
produceLogs mvar = do
    print "First"
    putMVar mvar "First log"
    print "Snd"
    putMVar mvar "Doing stuff"
    print "Thd"
    putMVar mvar "end"

consumeLogs mvar = do
    forever $ do
        log <- takeMVar mvar
        print log