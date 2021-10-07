module Main exposing (init, main, subscriptions, update, view)

import Browser exposing (Document)
import Data.Activity exposing (Activity(..))
import Data.Model exposing (Model)
import Data.Player exposing (playerDecoder, playerEncoder)
import Html exposing (div, text)
import Html.Attributes exposing (class)
import Json.Decode as De exposing (field, list)
import Json.Encode as En
import List.Extra exposing (getAt, setAt)
import Msg exposing (Msg(..))
import Ports
import View.PlayerEditor exposing (viewPlayerEditor)


main : Program De.Value Model Msg
main =
    Browser.document
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


init : De.Value -> ( Model, Cmd Msg )
init flags =
    let
        plyrs =
            case De.decodeValue (field "players" (list playerDecoder)) flags of
                Ok players ->
                    players

                Err e ->
                    []
    in
    ( { players = plyrs
      , activity = EditingPlayer 0
      }
    , Cmd.none
    )


view : Model -> Document Msg
view model =
    { title = "playgame"
    , body =
        [ div [ class "body" ]
            [ case List.head model.players of
                Just player ->
                    viewPlayerEditor player

                Nothing ->
                    text "nope"
            ]
        ]
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        UsernameEdited name ->
            case model.activity of
                EditingPlayer num ->
                    let
                        mPlayer =
                            getAt num model.players
                    in
                    case mPlayer of
                        Just player ->
                            let
                                players =
                                    setAt num { player | name = name } model.players
                            in
                            ( { model | players = players }
                            , Ports.setState <| En.list playerEncoder players
                            )

                        _ ->
                            ( model, Cmd.none )

        ColorEdited color ->
            case model.activity of
                EditingPlayer num ->
                    let
                        mPlayer =
                            getAt num model.players
                    in
                    case mPlayer of
                        Just player ->
                            let
                                players =
                                    setAt num { player | color = color } model.players
                            in
                            ( { model | players = players }
                            , Ports.setState <| En.list playerEncoder players
                            )

                        _ ->
                            ( model, Cmd.none )

        SaveStateRequested ->
            ( model, Ports.setState (En.list playerEncoder model.players) )

        GenderSelected gender ->
            case model.activity of
                EditingPlayer num ->
                    let
                        mPlayer =
                            getAt num model.players
                    in
                    case mPlayer of
                        Just player ->
                            ( { model | players = setAt num { player | gender = gender } model.players }, Cmd.none )

                        _ ->
                            ( model, Cmd.none )

        OrientationSelected orientation ->
            case model.activity of
                EditingPlayer num ->
                    let
                        mPlayer =
                            getAt num model.players
                    in
                    case mPlayer of
                        Just player ->
                            ( { model | players = setAt num { player | orientation = orientation } model.players }, Cmd.none )

                        _ ->
                            ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch <|
        []