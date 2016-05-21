module Location exposing (fromIndex, fromZone, Location)

import Size exposing (unitSize)
import Zone exposing (fromFlat)
import Constants exposing (boardZones)

-- Represents x/y coordinates from the center
type alias Location = (Float, Float)

-- Returns the location from the center point of the given zone index
fromIndex : Int -> Location
fromIndex index = fromZone <| fromFlat index

-- Gets the center pixel coordinates of the given zone coords
fromZone : (Int, Int) -> Location
fromZone (x, y) =
  let
    xFromCenter = toFloat x - (toFloat <| fst boardZones - 1) / 2
    yFromCenter = toFloat y - (toFloat <| snd boardZones - 1) / 2
  in
    (xFromCenter * fst unitSize, yFromCenter * snd unitSize)
