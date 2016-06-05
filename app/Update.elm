module Update exposing (update)

import Action exposing (Action(..))
import Model exposing (Model)
import List exposing (indexedMap)
import Types exposing (Piece(..), Player(..))
import Zone exposing (Zone)

update : Action -> Model -> (Model, Cmd Action)
update action model =
  case action of
    -- Place a piece in the given index; assumed the move is legal
    PlacePieceInIndex flatIndex ->
      let
        zoneToPlacePlayerPiece : Int -> List (Maybe Piece) -> Maybe Zone -> Maybe Zone
        zoneToPlacePlayerPiece index pieces acc =
          case pieces of
            [] -> acc
            piece :: pieces ->
              let recursiveResult = zoneToPlacePlayerPiece (index + 1) pieces acc
              in
                if index == flatIndex
                then case piece of
                  Nothing -> Just (Zone.fromFlat index)
                  _ -> recursiveResult
                else recursiveResult
        zone = zoneToPlacePlayerPiece 0 model.board Nothing
      in case zone of
        Nothing -> (model, Cmd.none)
        Just zone ->
          let
            index = Zone.toFlat <| zone
          in
            ( { model |
              board =
                let
                  mapper : Int -> Maybe Piece -> Maybe Piece
                  mapper index' currentPiece =
                    if index == index' then Just model.pieceOfPlayer else currentPiece
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
            , Cmd.none
            )
    _ -> (model, Cmd.none)
