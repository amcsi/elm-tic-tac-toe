module View (view) where

import Graphics.Collage exposing (collage, toForm)
import Signal exposing (Address)
import Action exposing (Action)
import Model exposing (Model)
import Html exposing (div, h1, text, Html, fromElement)
import Constants exposing (boardSize)
import View.Board exposing (board)

view : Address Action -> Model -> Html
view address model =
  div []
    [ h1 [] [ text "Tic-Tac-Toe" ]
    , fromElement <| collage (floor <| fst boardSize) (floor <| snd boardSize) <| board address model
    ]
