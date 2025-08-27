module Main (main) where

import Dice
import CharacterSheet

import System.Console.Haskeline

data Dungeon = Wall Int Int deriving (Show)

data Player = Player Int Int deriving (Show)

attack :: Int -> Sheet -> Sheet -> Bool
attack roll attacker defender =
  let acDefender = ac defender
      thac0Attacker = thac0 attacker
  in roll + acDefender >= thac0Attacker

damage :: Int -> Sheet -> Sheet
damage value player =
  let newHp = if value > (hp player) then 0 else (hp player) - value
  in Sheet{initiative = initiative player,
           thac0= thac0 player,
           ac= ac player,
           hp= newHp,
           weapon_damage= weapon_damage player}

player1 :: Sheet
player1 = Sheet{initiative=2,thac0=12,ac=0,hp=20,weapon_damage=3}

player2 :: Sheet
player2 = Sheet{initiative=3,thac0=16,ac=0,hp=20,weapon_damage=3}

main :: IO ()
main = do
  key <- runInputT defaultSettings (do getInputChar "Press a Key (or Ctrl+D to exit):")
  case key of
    Nothing -> putStrLn "Goodbye!"
    Just 'a' -> do
      roll <- d20
      putStrLn $ show roll
      let success = attack roll player1 player2
      putStrLn $ show success
      if success then putStrLn $ show $ damage (weapon_damage player1) player2 else putStrLn "Attack failed!"
      main
    Just char -> do
      putStrLn $ "You pressed: " ++ [char]
      main

{-main = runInputT defaultSettings loop
  where
    loop :: InputT IO ()
    loop = do
      minput <- getInputChar "Press a Key (or Ctrl+D to exit):"
      case minput of
        Nothing -> outputStrLn "Goodbye!"
        Just char -> do
          outputStrLn $ "You pressed: " ++ [char]
          roll <- d20
          loop
-}

{-
main = do
  let cols = foldl (\acc x -> '.':acc) "" $ take 120 [1..]
  putStrLn "Length: 120"
  putStrLn cols

  let lines = foldl (\acc x -> '.':'\n':acc) "" $ take 30 [1..]
  putStrLn "Length: 30"
  putStr lines
-}

-- NOTES
-- Windows PowerShell has 120 cols x 30 lines

--  putStrLn "Enter your name: "
--  name <- getLine
--  putStrLn("Hello, " ++ name ++ "!")
--  let success = PC.attack 20 player1 player2
--  putStrLn(show success)
