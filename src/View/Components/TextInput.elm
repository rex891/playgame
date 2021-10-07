module View.Components.TextInput exposing (..)

import Html exposing (div, input, label, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)


type TextInput msg
    = TextInput Options (String -> msg) String String


type alias Options =
    { width : String
    , placeholderText : String
    }


defaultOptions =
    { width = "100%"
    , placeholderText = ""
    }


textInput : String -> String -> (String -> msg) -> TextInput msg
textInput label value toMsg =
    TextInput defaultOptions toMsg label value


withWidth : String -> TextInput msg -> TextInput msg
withWidth width (TextInput options toMsg label value) =
    TextInput { options | width = width } toMsg label value


toHtml : TextInput msg -> Html.Html msg
toHtml (TextInput options toMsg lab val) =
    div
        [ style "display" "flex"
        , style "align-items" "center"
        , style "justify-content" "center"
        ]
        [ label [ for "text-in" ] [ text <| lab ++ ": " ]
        , input
            [ type_ "text"
            , id "text-in"
            , style "font-size" "1.5em"
            , style "margin-left" "10px"
            , style "height" "40px"
            , style "place-self" "center"
            , style "border-radius" "15px"
            , style "padding-left" "15px"
            , style "width" options.width
            , value val
            , onInput toMsg
            , autocomplete True
            , placeholder options.placeholderText
            ]
            []
        ]
