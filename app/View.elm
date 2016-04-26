module View (view) where

import Signal exposing (Address)
import Action exposing (Action)
import Model exposing (Model)
import Html exposing (div, text, Html)

view : Address Action -> Model -> Html
view _ _ =
  div []
    [ text "Hello world again!" ]
