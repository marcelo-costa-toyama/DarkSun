module Dice (d4, d20) where

import System.Random(randomRIO)

d4 :: IO Int
d4 = do
  ret <- randomRIO(1,4) :: IO Int
  return(ret)

d20 :: IO Int
d20 = do
  ret <- randomRIO(1,20) :: IO Int
  return(ret)
