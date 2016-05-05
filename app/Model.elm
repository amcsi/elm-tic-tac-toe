module Model (Model, Piece(..)) where

type Piece = X | O | Blank

type alias Model = {
  board : List Piece
}
