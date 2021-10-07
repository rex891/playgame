port module Ports exposing (..)

import Json.Encode as En


port setState : En.Value -> Cmd msg
