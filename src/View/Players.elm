module View.Players exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Svg
import Svg.Attributes as SA


view =
    div
        [ style "display" "flex"
        , style "flex-direction" "column"
        ]
        [ div
            [ style "height" "100px"
            , style "display" "flex"
            ]
            (List.indexedMap
                (\i v ->
                    buttonView v
                )
                (List.range 1 6)
            )
        , div [] [ text "ello plaers" ]
        ]


buttonView num =
    Svg.svg [ SA.width "100%", SA.height "100%" ] [ Svg.text <| String.fromInt num ]



-- div
--     [ style "flex-grow" "1"
--     , style "display" "flex"
--     , style "justify-content" "flex-start"
--     , style "align-items" "center"
--     , style "transform" "rotate(90deg)"
--     -- , style "padding" "10px"
--     ]
--     [ div [] [ text (String.fromInt num) ] ]
