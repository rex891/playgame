module Msg exposing (Msg(..))

import Data.Player exposing (Gender, Orientation)


type Msg
    = NoOp
    | SaveStateRequested
    | UsernameEdited String
    | ColorEdited String
    | GenderSelected Gender
    | OrientationSelected Orientation
