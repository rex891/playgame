module View.PlayerEditor exposing (..)

import Data.Player exposing (Edit(..), Gender(..), Orientation(..), Player)
import Html exposing (div)
import Html.Attributes exposing (class, style)
import Msg exposing (Msg(..))
import View.Components.ColorInput as CI
import View.Components.Radio as R
import View.Components.TextInput as TI


viewPlayerEditor : Player -> Html.Html Msg
viewPlayerEditor player =
    div
        [ style "color" "white"
        , style "display" "flex"
        , style "flex-direction" "column"
        , style "justify-content" "space-evenly"
        , style "gap" "30px"
        , style "max-width" "400px"
        , style "margin" "30px"
        ]
        [ TI.textInput "NAME" player.name (StateEdited << Name)
            |> TI.withWidth "100%"
            |> TI.toHtml
        , CI.colorInput "COLOR: " player.color (StateEdited << Color)
            |> CI.toHtml
        , R.radio
            { label = "GENDER:"
            , options = [ R.option Male "Male", R.option Female "Female" ]
            , selected = Just player.gender
            , toMsg = StateEdited << Gender
            }
            |> R.toRow
        , R.radio
            { label = "ORIENTATION:"
            , options = [ R.option Straight "Straight", R.option Gay "Gay", R.option Bisexual "Bisexual" ]
            , selected = Just player.orientation
            , toMsg = StateEdited << Orientation
            }
            |> R.toRow
        ]
