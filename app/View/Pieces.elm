module View.Pieces (pieces) where

import Model exposing (..)
import Graphics.Collage exposing (group, traced)
import Color exposing (blue, red)
import Signal exposing (Address)
import Action exposing (Action)
import Graphics.Collage exposing (Form, LineStyle, defaultLine, move, path, outlined, oval)
import List exposing (concat, indexedMap)
import Types exposing (Piece(..))
import Size exposing (unitSize)
import Size exposing (Size)
import Location exposing (fromZone, Location)
import Zone exposing (fromFlat, Zone)

pieces : Address Action -> Model -> List Form
pieces address model = drawPieces model.board

lineStyle : LineStyle
lineStyle = { defaultLine | width = 10 }

-- Draws pieces based on the board
drawPieces : List Piece -> List Form
drawPieces board =
  let
    mapper : Int -> Piece -> Form
    mapper index piece =
      group <| drawPiece piece <| fromFlat index
  in indexedMap mapper board

-- Draws a piece
drawPiece : Piece -> Zone -> List Form
drawPiece piece (x, y) =
  case piece of
    X ->
      let
        lineStyle' = { lineStyle | color = blue }
        coords = fromZone (x, y)
        line1 =
          [ ( negate <| fst cornerBoundaryLocalCoords
            , negate <| snd cornerBoundaryLocalCoords
            )
          , ( fst cornerBoundaryLocalCoords
            , snd cornerBoundaryLocalCoords
            )
          ]
        line2 =
          [ ( negate <| fst cornerBoundaryLocalCoords
            , snd cornerBoundaryLocalCoords
            )
          , ( fst cornerBoundaryLocalCoords
            , negate <| snd cornerBoundaryLocalCoords
            )
          ]
      in
        [ move coords <| group
          [ traced lineStyle' <| path line1
          , traced lineStyle' <| path line2
          ]
        ]
    O ->
      let
        lineStyle' = { lineStyle | color = red }
        oval' = uncurry oval ( fst cornerBoundaryLocalCoords * 2, snd cornerBoundaryLocalCoords * 2)
        coords = fromZone (x, y)
      in [ outlined lineStyle' oval' |> move coords ]
    _ -> []

-- Magic number that ought to be more dynamic
gridWidth : Float
gridWidth = 20

-- The effective amount of horizontal and vertical pixels the corner for drawing is inside a zone relative to the center
cornerBoundaryLocalCoords : Size
cornerBoundaryLocalCoords =
  let
    a = fst unitSize / 2
    b = snd unitSize / 2
  in
    (a - gridWidth, b - gridWidth)
