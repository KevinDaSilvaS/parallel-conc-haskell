module Concurrent.Example where

import Control.Concurrent
import Control.Monad
import System.IO

example = do
    hSetBuffering stdout NoBuffering
    forkIO $ replicateM_ 100000 (putChar 'A')
    replicateM_ 100000 (putChar 'B')