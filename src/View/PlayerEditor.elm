module View.PlayerEditor exposing (..)

import Data.Player exposing (Gender(..), Orientation(..), Player)
import Html exposing (div, input, label, text)
import Html.Attributes exposing (class, for, id, style, type_)
import Msg exposing (Msg(..))
import View.Components.ColorInput as CI
import View.Components.Radio as R
import View.Components.TextInput as TI


viewPlayerEditor : Player -> Html.Html Msg
viewPlayerEditor player =
    div [ class "player-editor", style "color" "white" ]
        [ TI.textInput "NAME" player.name UsernameEdited
            |> TI.withWidth "30%"
            |> TI.toHtml
        , CI.colorInput "COLOR: " player.color ColorEdited
            |> CI.toHtml
        , R.radio
            { label = "GENDER:"
            , options = [ R.option Male "Male", R.option Female "Female" ]
            , selected = Just player.gender
            , toMsg = GenderSelected
            }
            |> R.toRow
        , R.radio
            { label = "ORIENTATION:"
            , options = [ R.option Straight "Straight", R.option Gay "Gay", R.option Bisexual "Bisexual" ]
            , selected = Just player.orientation
            , toMsg = OrientationSelected
            }
            |> R.toRow
        ]
