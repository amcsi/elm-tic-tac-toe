module Init (init) where

import Effects exposing (Effects)
import Action exposing (Action)
import Model exposing (Model)
import Constants exposing (boardZones)
import List exposing (repeat)
import Types exposing (Piece(Blank, X), Player(Player1))

init : (Model, Effects Action)
init =
  ( { board = repeat (fst boardZones * snd boardZones) Blank
    , turnPlayer = Player1
    , pieceOfPlayer = X
    }
  , Effects.none
  )
