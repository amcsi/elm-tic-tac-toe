module Model (Model) where

import Types exposing (Piece, Player)

type alias Model =
  { board : List Piece
  , turnPlayer : Player
  , pieceOfPlayer : Piece
}
