module Update (update) where

import Effects exposing (Effects)
import Action exposing (Action(..))
import Model exposing (Model)
import List exposing (indexedMap)
import Types exposing (Piece(..), Player(..))

update : Action -> Model -> (Model, Effects Action)
update action model =
  case action of
    -- Place a piece in the given index; assumed the move is legal
    PlacePieceInIndex flatIndex ->
      ( { model |
          board =
            let
                mapper : Int -> Piece -> Piece
                mapper index currentPiece =
                  if index == flatIndex
                  then model.pieceOfPlayer
                  else currentPiece
            in indexedMap mapper model.board
        -- Flip the turn players
        , turnPlayer =
          if model.turnPlayer == Player1
          then Player2
          else Player1
        -- Flip the current player's piece
        , pieceOfPlayer =
          if model.pieceOfPlayer == X then O else X
        }
      , Effects.none
      )
    _ -> (model, Effects.none)
