module Concurrent.Channel where

import Control.Concurrent
import Control.Concurrent.Chan
import Control.Monad

example = do
    chan <- newChan
    forkIO $ replicateM_ 3 (writeChan chan "LOG ########")
    readChan chan >>= print
    readChan chan >>= print
    readChan chan >>= print
    forkIO $ writeChan chan "Fourth"
    readChan chan >>= print