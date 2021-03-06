module Location exposing (collageLocationToHtmlLocation, fromIndex, fromZone, Location)

import Size exposing (unitSize, Size)
import Zone exposing (fromFlat)
import Constants exposing (boardZones, boardSize)

(boardX, boardY) = boardZones
(boardWidth, boardHeight) = boardSize

-- Represents x/y coordinates from the center
type alias Location = (Float, Float)

-- Returns the location from the center point of the given zone index
fromIndex : Int -> Location
fromIndex index = fromZone <| fromFlat index

-- Gets the center pixel coordinates of the given zone coords
fromZone : (Int, Int) -> Location
fromZone (x, y) =
  let
    xFromCenter = toFloat x - (toFloat <| boardX - 1) / 2
    yFromCenter = toFloat y - (toFloat <| boardY - 1) / 2
  in
    (xFromCenter * fst unitSize, yFromCenter * snd unitSize)

-- Converts a box size and collage location to an html location; from center to from top left
-- Depends also on the boardSize
collageLocationToHtmlLocation : Size -> Location -> Location
collageLocationToHtmlLocation (sizeX, sizeY) (locationX, locationY) =
  let offsetX = boardWidth / 2 - sizeX / 2
      offsetY = boardHeight / 2 - sizeY / 2
  in (offsetX + locationX, offsetY - locationY)


