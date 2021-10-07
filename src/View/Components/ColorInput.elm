module View.Components.ColorInput exposing (..)

import Html exposing (div, input, label, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)


type ColorInput msg
    = ColorInput Options (String -> msg) String String


type alias Options =
    { width : String
    }


defaultOptions =
    { width = "100%"
    }


colorInput : String -> String -> (String -> msg) -> ColorInput msg
colorInput label value toMsg =
    ColorInput defaultOptions toMsg label value


withWidth : String -> ColorInput msg -> ColorInput msg
withWidth width (ColorInput options toMsg label value) =
    ColorInput { options | width = width } toMsg label value


toHtml : ColorInput msg -> Html.Html msg
toHtml (ColorInput options toMsg lab val) =
    div
        [ style "display" "flex"
        , style "align-items" "center"
        , style "justify-content" "center"
        ]
        [ label
            [ for "color-widget"
            , style "padding-right" "15px"
            ]
            [ text lab ]
        , input
            [ type_ "color"
            , id "color-widget"
            , style "width" "80px"
            , style "height" "50px"
            , value val
            , onInput toMsg
            ]
            []
        ]
