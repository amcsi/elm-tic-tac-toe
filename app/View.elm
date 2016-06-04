module View exposing (view)

import Collage exposing (collage, toForm)
import Element exposing (toHtml)
import Action exposing (Action)
import Model exposing (Model)
import Html exposing (div, h1, text, Html)
import Html.Attributes exposing (style)
import Constants exposing (boardSizeInt)
import View.Board exposing (board)
import View.Hotspots exposing (hotspots)
import View.Style.Size exposing (heightWidth)

(boardX, boardY) = boardSizeInt

view : Model -> Html Action
view model =
  let collageHtml =
    board model
    |> collage boardX boardY
    |> toHtml
  in
    div []
      [ h1 [] [ text "Tic-Tac-Toe" ]
      , div
        [style <| [("position", "relative")] ++ heightWidth boardSizeInt]
        (collageHtml :: hotspots)
      ]
