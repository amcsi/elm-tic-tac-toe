module Size exposing (unitSize, Size)

import Constants exposing (..)

type alias Size = (Float, Float)

-- The horizontal and vertical pixel size of a single box
unitSize : Size
unitSize =
  let
    unitWidth = fst boardSize / (toFloat <| fst boardZones)
    unitHeight = snd boardSize / (toFloat <| snd boardZones)
  in (unitWidth, unitHeight)
