module Model exposing (Model)

import Types exposing (Board, Piece, Player, Win)

type alias Model =
  { board : Board
  , turnPlayer : Player
  , pieceOfPlayer : Piece
  , wins : List Win
  }
