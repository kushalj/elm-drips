module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as Decode

type alias Model =
    { topic : String
    , gifUrl : String
    }


init : String -> ( Model, Cmd Msg )
init topic =
    let
        waitingUrl =
            "https://i.imgur.com/uozTnoB.gif"
            -- "https://i.imgur.com/i6eXrfS.gif"
    in
        ( Model topic waitingUrl
        , getRandomGif topic
        )


-- UPDATE

type Msg
    = RequestMore
    | NewGif (Result Http.Error String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        -- 
        RequestMore ->
            ( { model | gifUrl = "https://i.imgur.com/uozTnoB.gif" }, getRandomGif model.topic )


        NewGif result ->
            case result of
                Ok url ->
                    ( { model | gifUrl = url }, Cmd.none )
                
                Err _ ->
                    ( model, Cmd.none )


view : Model -> Html Msg
view model =
    div []
        [ h2 [] [ text model.topic ]
        , div [] [ img [ src model.gifUrl ] [] ]
        , button [ onClick RequestMore ] [ text "More, better..." ]
        ]


main =
    Html.program
        { init = init "crazy"
        , view = view
        , update = update
        , subscriptions = always Sub.none 
    }


getRandomGif : String -> Cmd Msg
getRandomGif topic =
    let
        url =
            "https://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=" ++ topic

        request =
            Http.get url decodedGifUrl
    in
        Http.send NewGif request


decodedGifUrl : Decode.Decoder String
decodedGifUrl =
    Decode.at [ "data", "image_url" ] Decode.string


