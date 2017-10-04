module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)


type alias Model =
  { counter : Int
  , decrements : Int
  , increments : Int
  }


type Msg
  = Increment
  | Decrement


initialModel : Model
initialModel = 
  { counter = 0
  , increments = 0
  , decrements = 0
  }
 

update: Msg -> Model -> Model
update msg model =
  case msg of
    Increment ->
      { model
        | counter = model.counter + 1
        , increments = model.increments + 1
      }

    Decrement ->
      { model
        | counter = model.counter - 1
        , decrements = model.decrements + 1
      }

view : Model -> Html Msg
view model =
  div [] 
    [ button [ onClick Decrement ] [ text "-" ]
    , div [] [ text (toString model.counter) ]
    , button [ onClick Increment ] [ text "+" ]
    , h3 [] [ text ("- clicked " ++ toString model.decrements ++ " times") ]
    , h3 [] [ text ("+ clicked " ++ toString model.increments ++ " times") ]
    ]
  

main =
  Html.beginnerProgram
    { model = initialModel 
    , view = view
    , update = update
    }
 

