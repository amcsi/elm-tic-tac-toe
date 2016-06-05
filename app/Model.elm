module Model exposing (Model)

import Types exposing (Piece, Player)

type alias Model =
  { board : List (Maybe Piece)
  , turnPlayer : Player
  , pieceOfPlayer : Piece
  }
