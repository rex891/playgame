module Data.Model exposing (..)

import Data.Activity exposing (Activity)
import Data.Player exposing (Player)


type alias Model =
    { players : List Player
    , activity : Activity
    }
