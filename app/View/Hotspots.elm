module View.Hotspots exposing (hotspots)

import Action exposing (Action(PlacePieceInIndex))
import Constants exposing (boardSizeInt)
import Zone exposing (listZones, toFlat)
import Location exposing (fromZone, collageLocationToHtmlLocation)
import Size exposing (unitSize)
import Html exposing (Html, div)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import View.Style.Size exposing (heightWidth)

hotspots : List (Html Action)
hotspots =
  let
    mapper zone =
      let (left, top) = fromZone zone |> collageLocationToHtmlLocation unitSize
          positionStyle =
            [ ("position", "absolute")
            , ("left", toString left ++ "px")
            , ("top", toString top ++ "px")
            ]
      in div
        [ style <| positionStyle ++ heightWidth unitSize
        , onClick (PlacePieceInIndex <| toFlat zone)
        ]
        []
  in List.map mapper listZones




