import Html exposing (Html)
import StartApp exposing (App)
import Model exposing (Model)
import View exposing (view)
import Update exposing (update)
import Init exposing (init)
import Inputs exposing (inputs)

app : App Model
app =
  StartApp.start
    { init = init
    , update = update
    , view = view
    , inputs = inputs
    }

main : Signal Html
main = app.html
