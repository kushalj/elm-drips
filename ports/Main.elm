port module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)


type alias Model =
    { counter : Int
    , decrements : Int
    , increments : Int
    }


initialModel : Model
initialModel =
    { counter = 0
    , increments = 0
    , decrements = 0
    }


type Msg
    = Increment
    | Decrement
    | NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment ->
            ( { model
                | counter = model.counter + 1
                , increments = model.increments + 1
              }
            , increment ()
            )

        Decrement ->
            ( { model
                | counter = model.counter - 1
                , decrements = model.decrements + 1
              }
            , Cmd.none
            )

        NoOp ->
            ( model, Cmd.none )


main =
    Html.program
        { init = ( initialModel, Cmd.none )
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


subscriptions model =
    jsMsgs mapJsMsg



-- OUTPUT ports
-- First, we want to add the outbound port we subscribed to from the JS side.
-- This is a function that takes one argument and returns a `Cmd`.  In our case,
-- we have nothing to send so we'll make its input type the unit.


port increment : () -> Cmd msg


port jsMsgs : (Int -> msg) -> Sub msg


mapJsMsg : Int -> Msg
mapJsMsg int =
    case int of
        1 ->
            Increment

        _ ->
            NoOp


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Decrement ] [ text "-" ]
        , div [] [ text (toString model.counter) ]
        , button [ onClick Increment ] [ text "+" ]
        , h3 [] [ text ("- clicked " ++ toString model.decrements ++ " times") ]
        , h3 [] [ text ("+ clicked " ++ toString model.increments ++ " times") ]
        ]
