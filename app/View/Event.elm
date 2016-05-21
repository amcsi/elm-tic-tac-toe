module View.Event exposing (events)

import Action exposing (Action(PlacePieceInIndex))
import Model exposing (Model)
import Types exposing (Piece(Blank))
import List exposing (filter, indexedMap, map)
import Size exposing (unitSize)
import Collage exposing (Form, move, toForm)
import Element exposing (spacer, Element)
--import Graphics.Input exposing (clickable)
import Location exposing (fromIndex)

events : Model -> List Form
events model =
  let
    indexesAndPieces = indexedMap (\index piece -> (index, piece)) model.board
    blanks : List (Int, Piece)
    blanks = filter (\(_, piece) -> piece == Blank) indexesAndPieces
    mapper : (Int, Piece) -> Form
    mapper (index, piece) =
      spacer (floor <| fst unitSize) (floor <| snd unitSize)
      --|> clickable (Signal.message <| PlacePieceInIndex index)
      |> toForm
      |> move (fromIndex index)
  in
    map mapper blanks
