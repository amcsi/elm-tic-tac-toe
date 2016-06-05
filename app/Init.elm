module Init exposing (init)

import Action exposing (Action)
import Model exposing (Model)
import Constants exposing (boardZones)
import List exposing (repeat)
import Types exposing (Piece(X), Player(Player1))

init : (Model, Cmd Action)
init =
  ( { board = repeat (fst boardZones * snd boardZones) Nothing
    , turnPlayer = Player1
    , pieceOfPlayer = X
    }
  , Cmd.none
  )
