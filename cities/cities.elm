module Main exposing (..)

import Html exposing (Attribute, Html, button, div, h1, h2, h3, li, p, pre, text, ul)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Json.Encode exposing (encode)
import Dict exposing (..)
import Dict.Extra exposing (..)
import String exposing (uncons)


main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }



-- MODEL


type alias City =
    { zipcode : String, state : String, city : String }


type alias GroupedCities =
    { groupName : String, cities : List City }


type alias Model =
    { name : String, result : Result }


type Result
    = ListOfCities (List City)
    | ListOfCitiesGrouped (Dict String (List City))
    | ListOfStates (Dict String Int)


groupByState : List City -> Dict String (List City)
groupByState list =
    list
        |> List.filter (\city -> city.state /= "State")
        |> Dict.Extra.groupBy (\city -> city.state)



-- UPDATE


type Msg
    = StartingList
    | GroupByState (List City)
    | FilterListByState (List City) String
    | StatesAndCityCount (List City)
    | StatesWithHiLoZip (List City)


startCase : String -> String
startCase string =
    case String.uncons string of
        Nothing ->
            string

        Just ( firstLetter, rest ) ->
            firstLetter
                |> String.fromChar
                |> String.toUpper
                |> (flip String.append) rest


countCities : List City -> Dict String Int
countCities list =
    list
        |> groupByState
        |> Dict.map (\stateName listOfCities -> List.length listOfCities)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        StartingList ->
            ( Model "Starting List" (ListOfCities rawCities), Cmd.none )

        GroupByState listOfCities ->
            ( Model "Grouped By State" (ListOfCitiesGrouped (groupByState listOfCities)), Cmd.none )

        FilterListByState list state ->
            ( Model "Filtered By TN" (ListOfCities (List.filter (\city -> city.state == state) list)), Cmd.none )

        StatesAndCityCount listOfCities ->
            ( Model "States and City Count" (ListOfStates (countCities listOfCities)), Cmd.none )

        _ ->
            ( Model "Starting List" (ListOfCities rawCities), Cmd.none )



-- VIEW


containerStyle : Attribute msg
containerStyle =
    style [ ( "padding", "20px" ) ]


liStyle : Attribute msg
liStyle =
    style [ ( "listStyle", "none" ), ( "padding", "0" ), ( "margin", "10px 0" ) ]


resultsList : Result -> Html msg
resultsList result =
    case result of
        ListOfStates states ->
            div []
                (List.map
                    (\( state, number ) ->
                        div []
                            [ p [] [ text (state ++ " - " ++ (toString number)) ]
                            ]
                    )
                    (Dict.toList states)
                )

        ListOfCities citiesList ->
            ul [] (List.map (\city -> li [] [ text (toString city) ]) citiesList)

        ListOfCitiesGrouped listOfGroups ->
            div []
                (List.map
                    (\( name, list ) ->
                        div []
                            [ h3 [] [ text name ]
                            , ul []
                                (List.map (\city -> li [] [ text (toString city) ]) list)
                            ]
                    )
                    (Dict.toList listOfGroups)
                )


view model =
    div [ containerStyle ]
        [ h1 [] [ text "Elm Lunch Homework" ]
        , ul
            [ style [ ( "listStyle", "none" ), ( "padding", "0" ), ( "margin", "0" ) ] ]
            [ li [ liStyle ] [ button [ onClick StartingList ] [ text "Starting list" ] ]
            , li [ liStyle ] [ button [ onClick (GroupByState rawCities) ] [ text "Group the cities by state" ] ]
            , li [ liStyle ] [ button [ onClick (FilterListByState rawCities "TN") ] [ text "Filter the cities to show TN only" ] ]
            , li [ liStyle ] [ button [ onClick (StatesAndCityCount rawCities) ] [ text "Show states and the count of cities" ] ]
            , li [ liStyle ] [ button [ onClick (StatesWithHiLoZip rawCities) ] [ text "Show states and the highest and lowest zip code for the state" ] ]
            ]
        , div []
            [ h2 [] [ text (model.name) ]
            , resultsList model.result
            ]
        ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- INIT


init : ( Model, Cmd Msg )
init =
    ( Model "Starting List" (ListOfCities rawCities), Cmd.none )



-- DATA


rawCities : List City
rawCities =
    [ { city = "City", state = "State", zipcode = "ZipCode" }
    , { city = "White Owl", state = "SD", zipcode = "57792" }
    , { city = "Whitewood", state = "SD", zipcode = "57793" }
    , { city = "Wounded Knee", state = "SD", zipcode = "57794" }
    , { city = "Zeona", state = "SD", zipcode = "57795" }
    , { city = "Adams", state = "TN", zipcode = "37010" }
    , { city = "Alexandria", state = "TN", zipcode = "37012" }
    , { city = "Antioch", state = "TN", zipcode = "37013" }
    , { city = "Sawyers Bar", state = "CA", zipcode = "96027" }
    , { city = "Fall River Mills", state = "CA", zipcode = "96028" }
    , { city = "Forks Of Salmon", state = "CA", zipcode = "96031" }
    , { city = "Arrington", state = "TN", zipcode = "37014" }
    , { city = "Ashland City", state = "TN", zipcode = "37015" }
    , { city = "Auburntown", state = "TN", zipcode = "37016" }
    , { city = "Beechgrove", state = "TN", zipcode = "37018" }
    , { city = "Belfast", state = "TN", zipcode = "37019" }
    , { city = "Bell Buckle", state = "TN", zipcode = "37020" }
    , { city = "Bethpage", state = "TN", zipcode = "37022" }
    , { city = "Big Rock", state = "TN", zipcode = "37023" }
    , { city = "Bon Aqua", state = "TN", zipcode = "37025" }
    , { city = "Bradyville", state = "TN", zipcode = "37026" }
    , { city = "Brentwood", state = "TN", zipcode = "37027" }
    , { city = "Bumpus Mills", state = "TN", zipcode = "37028" }
    , { city = "Burns", state = "TN", zipcode = "37029" }
    , { city = "Defeated", state = "TN", zipcode = "37030" }
    , { city = "Castalian Spring", state = "TN", zipcode = "37031" }
    , { city = "Cedar Hill", state = "TN", zipcode = "37032" }
    , { city = "Centerville", state = "TN", zipcode = "37033" }
    , { city = "Chapel Hill", state = "TN", zipcode = "37034" }
    , { city = "New Holland", state = "PA", zipcode = "17557" }
    , { city = "New Providence", state = "PA", zipcode = "17560" }
    , { city = "Chapmansboro", state = "TN", zipcode = "37035" }
    , { city = "Charlotte", state = "TN", zipcode = "37036" }
    , { city = "Christiana", state = "TN", zipcode = "37037" }
    ]
