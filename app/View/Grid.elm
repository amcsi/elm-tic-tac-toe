module View.Grid (grid) where

import Signal exposing (Address)
import Action exposing (Action)
import Model exposing (Model)
import Maybe exposing (withDefault, Maybe(Just))
import Graphics.Collage exposing (group, rotate, segment, traced, Form, LineCap(Round), LineJoin(Smooth), LineStyle, Path)
import Color exposing (Color)
import Constants exposing (boardSize)
import List exposing (..)

grid : Address Action -> Model -> List Form
grid address model = drawGrid boardSize (3, 3) gridWidth

gridWidth : Float
gridWidth = 10.0

margin : Float
margin = 10

lineStyle : LineStyle
lineStyle = { color = Color.black
  , width = gridWidth
  , cap = Round
  , join = Smooth
  , dashing = []
  , dashOffset = 0
  }

-- Get a list of split points to split a line into n equal lines
-- e.g. splitPoints 600 3 = [200.0, 400.0]
splitPoints : Float -> Int -> List Float
splitPoints width splitCount =
  case splitCount of
    0 -> []
    1 -> []
    _ ->
      let
        firstPoint = width / splitCount
        repeated = repeat (splitCount - 2) firstPoint
        folder : Float -> List Float -> List Float
        folder firstNumber accumulated =
          let lastValue =
            withDefault 0 (head << reverse <| accumulated)
          in append accumulated <| [lastValue + firstNumber]
      in foldl folder [firstPoint] repeated

drawGridLines : Bool -> Float -> List Float -> Form
drawGridLines isVertical max splitPoints' =
  let
    halfBoardSize = max / 2
    -- because we need them to be offset by the center
    splitPointsWithOffset = map (\splitPoints -> splitPoints - halfBoardSize) splitPoints'
    rotateIfVertical : Form -> Form
    rotateIfVertical form =
      if isVertical then form else rotate (degrees 90) form
    mapper : Float -> Path
    mapper splitPoint =
      segment (margin - halfBoardSize, splitPoint) (halfBoardSize - margin, splitPoint)
  in map mapper splitPointsWithOffset
    |> map (\path -> traced lineStyle path)
    |> group
    |> rotateIfVertical

-- Draws a grid onto a canvas of a given size, splitting the view into given amount by amount of spaces, with a given line width
drawGrid : (Float, Float) -> (Int, Int) -> Float -> List Form
drawGrid (canvasWidth, canvasHeight) (horizontalSpots, verticalSpots) lineWidth =
  [ drawGridLines False canvasWidth <| splitPoints canvasWidth horizontalSpots
  , drawGridLines True canvasHeight <| splitPoints canvasHeight verticalSpots
  ]
