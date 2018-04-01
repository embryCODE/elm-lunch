module Main exposing (..)

import Html exposing (Attribute, Html, button, div, h1, h2, h3, li, p, pre, text, ul)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Json.Encode exposing (encode)


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
    = SingleCity City
    | ListOfCities (List City)
    | ListOfCitiesGrouped ListOfCitiesGrouped


type alias ListOfCitiesGrouped =
    List GroupedCities


groupByField : List City -> String -> ListOfCitiesGrouped
groupByField listOfCities groupField =
    [ GroupedCities "testing123" rawCities ]



-- UPDATE


type Msg
    = StartingList
    | GroupBy (List City) String
    | FilterGroupBy ListOfCitiesGrouped String
    | StatesAndCityCount ListOfCitiesGrouped
    | StatesWithHiLoZip ListOfCitiesGrouped


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        StartingList ->
            ( Model "Starting List" (ListOfCities rawCities), Cmd.none )

        GroupBy listOfCities groupField ->
            ( Model ("Grouped By " ++ groupField) (ListOfCitiesGrouped (groupByField listOfCities groupField)), Cmd.none )

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
        SingleCity city ->
            div [] []

        ListOfCities citiesList ->
            ul [] (List.map (\city -> li [] [ text (toString city) ]) citiesList)

        ListOfCitiesGrouped listOfGroups ->
            div []
                (List.map
                    (\group ->
                        div []
                            [ h3 [] [ text group.groupName ]
                            , ul []
                                (List.map (\city -> li [] [ text (toString city) ]) group.cities)
                            ]
                    )
                    listOfGroups
                )


view model =
    div [ containerStyle ]
        [ h1 [] [ text "Elm Lunch Homework" ]
        , ul
            [ style [ ( "listStyle", "none" ), ( "padding", "0" ), ( "margin", "0" ) ] ]
            [ li [ liStyle ] [ button [ onClick StartingList ] [ text "Starting list" ] ]
            , li [ liStyle ] [ button [ onClick (GroupBy rawCities "state") ] [ text "Group the cities by state" ] ]
            , li [ liStyle ] [ button [ onClick StartingList ] [ text "Filter the cities to show TN only" ] ]
            , li [ liStyle ] [ button [ onClick StartingList ] [ text "Show states and the count of cities" ] ]
            , li [ liStyle ] [ button [ onClick StartingList ] [ text "Show states and the highest and lowest zip code for the state" ] ]
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
