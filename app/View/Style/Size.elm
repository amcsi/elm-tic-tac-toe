module View.Style.Size exposing (heightWidth)

import Html exposing (Attribute)

heightWidth : (number, number) -> List (String, String)

heightWidth (width, height) =
  let
    toPxString : number -> String
    toPxString num =
      toString num ++ "px"
  in
    [ ( "width", toPxString width ), ( "height", toPxString height ) ]
