-- Module related to the zones of the board (3x3)
module Zone exposing (fromFlat, listZones, toFlat, Zone)
import Constants exposing (boardZones)

(boardX, boardY) = boardZones

type alias Zone = (Int, Int)

-- Converts a flat index to a 2d index
fromFlat : Int -> Zone
fromFlat flatIndex = (flatIndex `rem` boardX, flatIndex // boardY)

-- Converts a Zone to a flat index
toFlat : Zone -> Int
toFlat (x, y) =
  y * boardX + x

-- Lists all the possible zones
listZones : List Zone
listZones =
  List.concatMap (\x -> List.map (\y -> (x, y)) [0..2]) [0..2]
