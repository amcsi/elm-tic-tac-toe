module Init (init) where

import Effects exposing (Effects)
import Action exposing (Action)
import Model exposing (Model, Piece(Blank))
import Constants exposing (boardZones)
import List exposing (repeat)

init : (Model, Effects Action)
init = ( { board = repeat (fst boardZones * snd boardZones) Blank }
  , Effects.none)
