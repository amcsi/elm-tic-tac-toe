module View.Grid (grid) where

import Signal exposing (Address)
import Action exposing (Action)
import Model exposing (Model)
import Maybe exposing (withDefault, Maybe(Just))
import Graphics.Collage exposing (group, move, rotate, path, traced, Form, LineCap(Round), LineJoin(Smooth), LineStyle, Path)
import Color exposing (Color)
import Constants exposing (boardSize)
import List exposing (..)

grid : Address Action -> Model -> List Form
grid address model = drawGrid boardSize (3, 3)

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

bottomLeftToCenter : Form -> Form
bottomLeftToCenter form =
  move (negate <| fst boardSize / 2, negate <| snd boardSize / 2) form

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
        repeated = repeat splitCount ()
        mapper : Int -> () -> Float
        mapper index _ = toFloat index * firstPoint
      in indexedMap mapper repeated
          |> tail
          |> withDefault []

drawGridLines : Bool -> (Float, Float) -> Int -> Form
drawGridLines isVertical (width, height) parts =
  let
    (perpendicularSize, parallelSize) = if isVertical then (width, height) else (height, width)
    splitPoints' = splitPoints perpendicularSize parts
    flipPathIfVertical : List (Float, Float) -> List (Float, Float)
    flipPathIfVertical list =
      if isVertical then map (\(x, y) -> (y, x)) list else list
    rotateIfVertical : Form -> Form
    rotateIfVertical form =
      if isVertical then form else rotate (degrees 90) form
    mapper : Float -> Form
    mapper splitPoint =
      flipPathIfVertical [(margin, splitPoint), (parallelSize - margin, splitPoint)]
        |> path
        |> traced lineStyle
  in map mapper splitPoints'
    |> group
    |> bottomLeftToCenter

-- Draws a grid onto a canvas of a given size, splitting the view into given amount by amount of spaces, with a given line width
drawGrid : (Float, Float) -> (Int, Int) -> List Form
drawGrid size (horizontalSpots, verticalSpots) =
  [ drawGridLines False size horizontalSpots
  , drawGridLines True size verticalSpots
  ]
