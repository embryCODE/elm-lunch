module Main exposing (..)

import Html exposing (Attribute, Html, button, div, h1, h2, li, p, text, ul)
import Html.Attributes exposing (style)


main =
    Html.beginnerProgram
        { model = model
        , update = update
        , view = view
        }



-- MODEL


model =
    { name = "Assignment Name", result = "Assignment Result" }



-- UPDATE


update msg model =
    { model | result = model.result, name = model.name }



-- VIEW


containerStyle =
    style [ ( "padding", "20px" ) ]


liStyle =
    style [ ( "listStyle", "none" ), ( "padding", "0" ), ( "margin", "10px 0" ) ]


view model =
    div [ containerStyle ]
        [ h1 [] [ text "Elm Lunch Homework" ]
        , ul
            [ style [ ( "listStyle", "none" ), ( "padding", "0" ), ( "margin", "0" ) ] ]
            [ li [ liStyle ] [ button [] [ text "Map the cities from the CSV" ] ]
            , li [ liStyle ] [ button [] [ text "Group the cities by state" ] ]
            , li [ liStyle ] [ button [] [ text "Filter the cities to show TN only" ] ]
            , li [ liStyle ] [ button [] [ text "Show states and the count of cities" ] ]
            , li [ liStyle ] [ button [] [ text "Show states and the highest and lowest zip code for the state" ] ]
            ]
        , div []
            [ h2 [] [ text model.name ]
            , p [] [ text model.result ]
            ]
        ]
