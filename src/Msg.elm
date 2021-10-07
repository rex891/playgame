module Msg exposing (Msg(..))

import Data.Player exposing (Edit)


type Msg
    = NoOp
    | StateEdited Edit
