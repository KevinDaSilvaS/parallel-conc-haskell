module Concurrent.Reminder where

import Control.Concurrent
import Control.Monad
import System.IO

example = do
    forever $ do
        input <- getLine
        time <- getLine
        let waitTime = read time :: Int
        forkIO $ reminder input waitTime

reminder input time = do
    threadDelay (10^6 * time)
    print input