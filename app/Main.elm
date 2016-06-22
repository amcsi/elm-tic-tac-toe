import Html exposing (Html)
import Html.App exposing (program)
import Model exposing (Model)
import View exposing (view)
import Update exposing (update)
import Init exposing (init)


app : Program Never
app =
  program
    { init = init
    , update = update
    , view = view
    , subscriptions = \_ -> Sub.none
    }

main = app
