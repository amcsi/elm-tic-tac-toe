module Init (init) where

import Effects exposing (Effects)
import Action exposing (Action)
import Model exposing (Model)

init : (Model, Effects Action)
init = ((), Effects.none)
