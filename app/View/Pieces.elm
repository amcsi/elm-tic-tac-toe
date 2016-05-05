module View.Pieces (pieces) where

import Model exposing (..)
import Graphics.Collage exposing (group, traced)
import Color exposing (blue, red)
import Signal exposing (Address)
import Action exposing (Action)
import Graphics.Collage exposing (Form, LineStyle, defaultLine, move, path, outlined, oval)
import Constants exposing (..)
import List exposing (concat)

pieces : Address Action -> Model -> List Form
pieces address model =
  [ group <| concat <| [ drawPiece X (0, 0), drawPiece O (0, 1) ] ]

lineStyle : LineStyle
lineStyle = { defaultLine | width = 10 }

drawPiece : Piece -> (Int, Int) -> List Form
drawPiece piece (x, y) =
  case piece of
    X ->
      let
        lineStyle' = { lineStyle | color = blue }
        coords = getCoords (x, y)
        line1 =
          [ ( negate <| fst cornerBoundaryLocalCoords
            , negate <| snd cornerBoundaryLocalCoords
            )
          , ( fst cornerBoundaryLocalCoords
            , snd cornerBoundaryLocalCoords
            )
          ]
        line2 =
          [ ( negate <| fst cornerBoundaryLocalCoords
            , snd cornerBoundaryLocalCoords
            )
          , ( fst cornerBoundaryLocalCoords
            , negate <| snd cornerBoundaryLocalCoords
            )
          ]
      in
        [ move coords <| group
          [ traced lineStyle' <| path line1
          , traced lineStyle' <| path line2
          ]
        ]
    O ->
      let
        lineStyle' = { lineStyle | color = red }
        oval' = uncurry oval ( fst cornerBoundaryLocalCoords * 2, snd cornerBoundaryLocalCoords * 2)
        coords = getCoords (x, y)
      in [ outlined lineStyle' oval' |> move coords ]
    _ -> []

gridWidth : Float
gridWidth = 20

cornerBoundaryLocalCoords : (Float, Float)
cornerBoundaryLocalCoords =
  let
    a = fst unitSize / 2
    b = snd unitSize / 2
  in
    (a - gridWidth, b - gridWidth)

unitSize : (Float, Float)
unitSize =
  let
    unitWidth = fst boardSize / (toFloat <| fst boardZones)
    unitHeight = snd boardSize / (toFloat <| snd boardZones)
  in (unitWidth, unitHeight)

getCoords : (Int, Int) -> (Float, Float)
getCoords (x, y) =
  let
    xFromCenter = toFloat x - (toFloat <| fst boardZones - 1) / 2
    yFromCenter = toFloat y - (toFloat <| snd boardZones - 1) / 2
  in
    (xFromCenter * fst unitSize, yFromCenter * snd unitSize)
