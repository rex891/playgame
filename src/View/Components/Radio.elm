module View.Components.Radio exposing (..)

import Html exposing (div, label, span, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)


type Radio msg val
    = Radio RadioConfig (RadioParams msg val)


type alias RadioParams msg val =
    { label : String
    , options : List (Option val msg)
    , selected : Maybe val
    , toMsg : val -> msg
    }


type alias RadioConfig =
    { width : String
    }


defaultRadioConfig =
    { width = "100%"
    }


type alias OptionConfig =
    { width : String
    }


defaultOptionConfig : OptionConfig
defaultOptionConfig =
    { width = "100%"
    }


type Option value msg
    = Option OptionConfig value String


option : val -> String -> Option val msg
option value label =
    Option defaultOptionConfig value label


radio : RadioParams msg val -> Radio msg val
radio radioParams =
    Radio defaultRadioConfig radioParams


withWidth : String -> Radio msg val -> Radio msg val
withWidth width (Radio config params) =
    Radio { config | width = width } params


toRow : Radio msg value -> Html.Html msg
toRow (Radio radioConfig radioParams) =
    div
        [ style "display" "flex"
        , style "align-items" "center"

        -- , style "justify-content" "center"
        , style "width" radioConfig.width
        ]
        [ span [ style "padding-right" "10px" ] [ text radioParams.label ]
        , span
            [ style "border" "2px solid black"
            , style "background-color" "white"
            , style "color" "black"
            , style "border-radius" "14px"
            , style "height" "40px"
            , style "display" "flex"
            ]
          <|
            List.map
                (\(Option optionConfig optionValue lab) ->
                    div
                        [ style "padding" "10px"
                        , style "width" optionConfig.width
                        , classList [ ( "selectedRadio", Just optionValue == radioParams.selected ) ]
                        , onClick <| radioParams.toMsg optionValue
                        ]
                        [ text lab ]
                )
                radioParams.options
        ]
