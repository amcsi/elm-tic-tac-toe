module View (view) where

import Graphics.Collage exposing (collage, toForm)
import Graphics.Input exposing (clickable)
import Signal exposing (Address, Signal)
import Action exposing (Action(ClickBoard))
import Model exposing (Model)
import Html exposing (div, h1, text, Html, fromElement)
import Constants exposing (boardSize)
import View.Board exposing (board)

view : Address Action -> Model -> Html
view address model =
  let collageHtml =
    board address model
    |> collage (floor <| fst boardSize) (floor <| snd boardSize)
    |> fromElement
  in
    div []
      [ h1 [] [ text "Tic-Tac-Toe" ]
      , collageHtml
      ]
