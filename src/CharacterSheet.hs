module CharacterSheet (Sheet(..)) where

data Sheet = Sheet {
  initiative :: Int,
  thac0 :: Int,
  ac :: Int,
  hp :: Int,
  weapon_damage :: Int
  }deriving (Show)
