module MyCards exposing (..)

import Html exposing (..)
import Html.Attributes


type alias Model =
    { name : String
    , gridArea : String
    , gridTemplateArea : GridTemplateArea
    }


type alias GridTemplateArea =
    {}
