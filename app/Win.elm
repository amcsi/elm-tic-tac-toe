module Win exposing (check, Win)

import Maybe exposing (Maybe(..))
import Constants exposing (boardZones)
import Zone exposing (Zone, listZones, toFlat)
import List exposing (foldr)
import Model exposing (Model)
import Helper.Piece exposing (indexPieces, opposite, IndexedPiece)
import Types exposing (Piece, Player)
import Helper.Piece exposing (owner)

(boardX, boardY) = boardZones

type WinCheck =
  Winning Piece
  | NoWin

type alias Win =
  { player: Player
  , zones: List Zone
  }

type alias IndexedMaybePiece = (Int, Maybe Piece)

getPiecesListByZoneList : List Zone -> List (Maybe Piece) -> List (Maybe Piece)
getPiecesListByZoneList zones board =
  let
    indexes = List.map toFlat zones
    iteratePieces : Int -> List (Maybe Piece) -> List (Maybe Piece)
    iteratePieces index pieces =
      case pieces of
        [] -> []
        piece :: pieces' ->
          let recursiveResult = iteratePieces (index + 1) pieces
          in if List.member index indexes then piece :: recursiveResult  else recursiveResult
  in iteratePieces 0 board


-- Returns the list of Wins for the model
checkWins : Model -> List Win
checkWins model =
  let
    winZoneCombinationMapper : List Zone -> List Win
    winZoneCombinationMapper zones =
      let
        pieces = getPiecesListByZoneList zones model.board
        winCheck = check pieces
      in
        case winCheck of
          NoWin -> []
          Winning piece ->
            let
              player = owner piece
            in
              [ { player = player
                , zones = zones
                }
              ]

  in List.concat <| List.map winZoneCombinationMapper winZoneCombinations

-- Lists all the combinations of zones where winning is possible
winZoneCombinations : List (List Zone)
winZoneCombinations =
  let
    horizontals =
      List.map (\y' -> List.filter (\(x, y) -> y' == y) listZones) [0..boardY-1]
    verticals =
      List.map (\x' -> List.filter (\(x, y) -> x' == x) listZones) [0..boardX-1]
    diagonals =
      let
        mapper inverse =
          let
            diagonalMapper : Int -> Zone
            diagonalMapper index =
              (index, if inverse then (boardY - 1 - index) else index)
          in List.map diagonalMapper [0..boardY]
      in List.map mapper [True, False]
  in List.concat [horizontals, verticals, diagonals]

-- Checks a list of maybe pieces to see if there's a win
check : List (Maybe Piece) -> WinCheck
check pieces =
  let
      -- Returns Just X/O if there's a rin, Just Blank if there's no win, and is initialized with Nothing
      matchingFolder : Maybe Piece -> Maybe WinCheck -> Maybe WinCheck
      matchingFolder piece winningPiece =
        case piece of
          Nothing -> Just NoWin
          Just piece ->
            case winningPiece of
              -- If these fields are not winning, then continue not winning
              Just NoWin -> Just NoWin
              -- If we don't know if a piece is winning yet, make the first piece the winning one
              Nothing -> Just (Winning piece)
              Just (Winning winningPiece) ->
                if winningPiece == piece then Just (Winning winningPiece) else Just NoWin
  in
      List.foldl matchingFolder Nothing pieces
      |> Maybe.withDefault NoWin

