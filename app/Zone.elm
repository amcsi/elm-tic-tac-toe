-- Module related to the zones of the board (3x3)
module Zone (fromFlat, Zone) where
import Constants exposing (boardZones)

type alias Zone = (Int, Int)

-- Converts a flat index to a 2d index
fromFlat : Int -> Zone
fromFlat flatIndex = (flatIndex `rem` (fst boardZones), flatIndex // (snd boardZones))
