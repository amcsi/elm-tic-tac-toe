module Constants exposing (boardSize, boardSizeInt, boardZones)

boardSize : (Float, Float)
boardSize = (300, 300)

boardSizeInt : (Int, Int)
boardSizeInt = (floor <| fst boardSize, floor <| snd boardSize)

boardZones : (Int, Int)
boardZones = (3, 3)
