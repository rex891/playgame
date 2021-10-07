module Data.Player exposing (..)

import Dict
import Json.Decode as De exposing (string)
import Json.Decode.Pipeline exposing (required)
import Json.Encode as En


type alias Player =
    { name : String
    , gender : Gender
    , orientation : Orientation
    , color : String
    }


type Edit
    = Name String
    | Color String
    | Gender Gender
    | Orientation Orientation


type Orientation
    = Straight
    | Gay
    | Bisexual


orientationDict =
    Dict.fromList [ ( "Straight", Straight ), ( "Gay", Gay ), ( "Bisexual", Bisexual ) ]


orientationToString : Orientation -> String
orientationToString orientation =
    case orientation of
        Straight ->
            "Straight"

        Gay ->
            "Gay"

        Bisexual ->
            "Bisexual"


type Gender
    = Male
    | Female


decodeGender =
    De.map
        (\gen ->
            if gen == "m" then
                Male

            else
                Female
        )
        string


encodeGender gender =
    case gender of
        Male ->
            "m"

        Female ->
            "f"


encodeOrientation orientation =
    case orientation of
        Straight ->
            "s"

        Gay ->
            "g"

        Bisexual ->
            "b"


decodeOrientation =
    De.map
        (\orien ->
            case orien of
                "s" ->
                    Straight

                "g" ->
                    Gay

                _ ->
                    Bisexual
        )
        string


playerDecoder =
    De.succeed Player
        |> required "name" string
        |> required "gender" decodeGender
        |> required "orientation" decodeOrientation
        |> required "color" string


playerEncoder player =
    En.object
        [ ( "name", En.string player.name )
        , ( "color", En.string player.color )
        , ( "gender", En.string (encodeGender player.gender) )
        , ( "orientation", En.string (encodeOrientation player.orientation) )
        ]
