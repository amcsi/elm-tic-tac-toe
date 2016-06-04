module Size exposing (unitSize, Size)

import Constants exposing (..)
import Zone exposing (Zone)

type alias Size = (Float, Float)

(boardX, boardY) = boardZones

-- The horizontal and vertical pixel size of a single box
unitSize : Size
unitSize =
  let
    unitWidth = fst boardSize / (toFloat boardX)
    unitHeight = snd boardSize / (toFloat boardY)
  in (unitWidth, unitHeight)
