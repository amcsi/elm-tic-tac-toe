module Action (Action(..)) where

type Action =
  PlacePieceInIndex Int
  | NoOp
