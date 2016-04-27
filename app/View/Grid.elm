module View.Grid (grid) where

import Signal exposing (Address)
import Action exposing (Action)
import Model exposing (Model)
import Maybe exposing (withDefault, Maybe(Just))
import Graphics.Collage exposing (group, rotate, segment, traced, Form, LineCap(Round), LineJoin(Smooth), LineStyle, Path)
import Color exposing (Color)
import Constants exposing (boardSize, gridWidth)
import List exposing (..)

grid : Address Action -> Model -> List Form
grid address model = drawGrid boardSize (3, 3) gridWidth

-- Get a list of split points to split a line into n equal lines
-- e.g. splitPoints 600 3 = [200.0, 400.0]
splitPoints : Int -> Int -> List Float
splitPoints width splitCount =
  case splitCount of
    0 -> []
    1 -> []
    _ ->
      let
        firstPoint = toFloat (width) / toFloat (splitCount)
        repeated = repeat (splitCount - 2) firstPoint
        folder : Float -> List Float -> List Float
        folder firstNumber accumulated =
          let lastValue =
            withDefault 0 (head << reverse <| accumulated)
          in append accumulated <| [lastValue + firstNumber]
      in foldl folder [firstPoint] repeated

drawGridLines : Bool -> Int -> List Float -> Form
drawGridLines isVertical max splitPoints' =
  let
    margin = 10
    lineStyle : LineStyle
    lineStyle = { color = Color.black
    , width = gridWidth
    , cap = Round
    , join = Smooth
    , dashing = []
    , dashOffset = 0
    }
    rotateIfVertical : Form -> Form
    rotateIfVertical form =
      if isVertical then form else rotate (degrees 90) form
    mapper : Float -> Path
    mapper splitPoint =
      segment (margin, splitPoint) (toFloat max - margin, splitPoint)
  in map mapper splitPoints'
    |> map (\path -> traced lineStyle path)
    |> group
    |> rotateIfVertical

-- Draws a grid onto a canvas of a given size, splitting the view into given amount by amount of spaces, with a given line width
drawGrid : (Int, Int) -> (Int, Int) -> Float -> List Form
drawGrid (canvasWidth, canvasHeight) (horizontalSpots, verticalSpots) lineWidth =
  [ drawGridLines False canvasWidth <| splitPoints canvasWidth horizontalSpots
  , drawGridLines True canvasHeight <| splitPoints canvasHeight verticalSpots
  ]
