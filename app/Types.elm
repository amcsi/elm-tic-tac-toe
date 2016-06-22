module Types exposing (Board, Player(..), Piece(..), Win)

import Zone exposing (Zone)

type Player = Player1 | Player2

type Piece = X | O

type alias Win =
  { player: Player
  , zones: List Zone
  }

type alias Board = List (Maybe Piece)
