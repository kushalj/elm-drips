port module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Task exposing (Task)


type alias Model =
    Int


initialModel : Model
initialModel =
    0


type Msg
    = Increment
    | Send


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment ->
            ( model + 1
            , Cmd.none
            )

        Send ->
            ( model
            , outbound model
            )


main =
    Html.program
        { init = ( initialModel, Cmd.none )
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


subscriptions model =
    increment mapIncrement


mapIncrement : {} -> Msg
mapIncrement _ =
    Increment



-- INPUT PORTS
-- Our inbound increment port that takes in an empty record
-- NOTE: This would normally be the Unit - () - but at the time of this writing there's a compiler bug related to the use of that, and this helps us get around it without changing the semantics at all.


port increment : ({} -> msg) -> Sub msg



-- OUTPUT ports
-- our outbound port for the current data to go out on


port outbound : Int -> Cmd msg


view : Model -> Html Msg
view model =
    div []
        [ div [] [ text (toString model) ]
        , button [ onClick Send ] [ text "Send" ]
        ]
