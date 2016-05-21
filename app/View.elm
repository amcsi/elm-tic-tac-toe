module View exposing (view)

import Collage exposing (collage, toForm)
import Element exposing (toHtml)
import Action exposing (Action)
import Model exposing (Model)
import Html exposing (div, h1, text, Html)
import Constants exposing (boardSize)
import View.Board exposing (board)

view : Model -> Html msg
view model =
  let collageHtml =
    board model
    |> collage (floor <| fst boardSize) (floor <| snd boardSize)
    |> toHtml
  in
    div []
      [ h1 [] [ text "Tic-Tac-Toe" ]
      , collageHtml
      ]
