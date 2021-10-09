module Main exposing (init, main, subscriptions, update, view)

import Browser exposing (Document)
import Data.Activity exposing (Activity(..))
import Data.Model exposing (Model)
import Data.Player exposing (Edit(..), playerDecoder, playerEncoder)
import Html exposing (div, text)
import Html.Attributes exposing (class)
import Json.Decode as De exposing (field, list)
import Json.Encode as En
import List.Extra exposing (getAt, setAt)
import Msg exposing (Msg(..))
import Ports
import View.PlayerEditor exposing (viewPlayerEditor)
import View.Players


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

                Err _ ->
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
            [ View.Players.view ]
        ]
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        StateEdited edit ->
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
                                    setAt num
                                        (case edit of
                                            Name name ->
                                                { player | name = name }

                                            Orientation orientation ->
                                                { player | orientation = orientation }

                                            Gender gender ->
                                                { player | gender = gender }

                                            Color color ->
                                                { player | color = color }
                                        )
                                        model.players
                            in
                            ( { model | players = players }
                            , Ports.setState <| En.list playerEncoder players
                            )

                        _ ->
                            ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.batch <|
        []
