module View.Board (board) where

import Signal exposing (Address)
import Action exposing (Action)
import Model exposing (Model)
--import Graphics.Element exposing (empty, Element)
import Graphics.Collage exposing (Form)
import View.Grid exposing (grid)
import View.Pieces exposing (pieces)
import List exposing (concat)

board : Address Action -> Model -> List Form
board address model = concat
  [ grid address model
  , pieces address model
  ]

