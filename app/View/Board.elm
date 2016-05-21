module View.Board exposing (board)

import Action exposing (Action)
import Model exposing (Model)
--import Graphics.Element exposing (empty, Element)
import Collage exposing (Form)
import View.Grid exposing (grid)
import View.Pieces exposing (pieces)
import View.Event exposing (events)
import List exposing (concat)

-- Draws the different bits of the board
board : Model -> List Form
board model = concat
  [ grid model
  , pieces model
  , events model
  ]

