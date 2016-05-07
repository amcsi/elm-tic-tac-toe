module View.Pieces (pieces) where

import Model exposing (..)
import Graphics.Collage exposing (group, traced)
import Color exposing (blue, red)
import Signal exposing (Address)
import Action exposing (Action)
import Graphics.Collage exposing (Form, LineStyle, defaultLine, move, path, outlined, oval)
import Constants exposing (..)
import List exposing (concat, indexedMap)

pieces : Address Action -> Model -> List Form
pieces address model = drawPieces model.board

-- Converts a flat index to a 2d index
coords2D : Int -> (Int, Int)
coords2D flatIndex = (flatIndex `rem` (fst boardZones), flatIndex // (snd boardZones))

lineStyle : LineStyle
lineStyle = { defaultLine | width = 10 }

-- Draws pieces based on the board
drawPieces : List Piece -> List Form
drawPieces board =
  let
    mapper : Int -> Piece -> Form
    mapper index piece =
      group <| drawPiece piece <| coords2D index
  in indexedMap mapper board

-- Draws a piece
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

-- Magic number that ought to be more dynamic
gridWidth : Float
gridWidth = 20

-- The effective amount of horizontal and vertical pixels the corner for drawing is inside a zone relative to the center
cornerBoundaryLocalCoords : (Float, Float)
cornerBoundaryLocalCoords =
  let
    a = fst unitSize / 2
    b = snd unitSize / 2
  in
    (a - gridWidth, b - gridWidth)

-- The horizontal and vertical pixel size of a single box
unitSize : (Float, Float)
unitSize =
  let
    unitWidth = fst boardSize / (toFloat <| fst boardZones)
    unitHeight = snd boardSize / (toFloat <| snd boardZones)
  in (unitWidth, unitHeight)

-- Gets the center pixel coordinates of the given zone coords
getCoords : (Int, Int) -> (Float, Float)
getCoords (x, y) =
  let
    xFromCenter = toFloat x - (toFloat <| fst boardZones - 1) / 2
    yFromCenter = toFloat y - (toFloat <| snd boardZones - 1) / 2
  in
    (xFromCenter * fst unitSize, yFromCenter * snd unitSize)
