module Update (update) where

import Effects exposing (Effects)
import Action exposing (Action)
import Model exposing (Model)

update : Action -> Model -> (Model, Effects Action)
update _ _ = ((), Effects.none)

