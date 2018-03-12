module MyCV exposing (..)

--import Html exposing (..)
--import Html.Attributes exposing (class, style)

import Html
import Html.Attributes
import Color
import Style
import Style.Font as Font
import Style.Color as Color
import Element exposing (..)
import Element.Attributes exposing (..)


type alias Model =
    { name : String
    , education : List Education
    , training : List Training
    , experience : List Experience
    , publications : List Publications
    , interests : Interests
    , certifications : Certs
    }


type alias Education =
    { description : String
    , location : String
    , dates : String
    }


type alias Training =
    { title : String
    , location : String
    , dates : String
    , description : String
    }


type alias Experience =
    { position : String
    , location : String
    , dates : String
    , description : String
    }


type alias Publications =
    { title : String
    , authors : String
    , citation : String
    }


type alias Interests =
    List String


type alias Certs =
    List String


type CVCategory
    = CVExperience
    | CVEducation
    | CVTraining
    | CVPublications
    | CVInterests
    | CVCerts


type MyStyles
    = Header
    | HeaderText
    | Card
    | CardHeader
    | CardSubheader
    | CardText
    | None
    | Background


type MyColors
    = DarkPrimary
    | Primary
    | LightPrimary
    | DarkSecondary
    | Secondary
    | LightSecondary
    | PrimaryText
    | SecondaryText
    | White
    | Black


type MyFonts
    = Headline
    | PrimarySans
    | SecondarySans
    | PrimarySerif
    | SecondarySerif
    | Fallback


fontStack : MyFonts -> Style.Font
fontStack font =
    case font of
        Headline ->
            Font.importUrl { url = "https://fonts.googleapis.com/css?family=Dosis", name = "dosis" }

        PrimarySans ->
            Font.importUrl { url = "https://fonts.googleapis.com/css?family=Roboto", name = "roboto" }

        SecondarySans ->
            Font.sansSerif

        PrimarySerif ->
            Font.importUrl { url = "https://fonts.googleapis.com/css?family=Esteban", name = "esteban" }

        SecondarySerif ->
            Font.serif

        Fallback ->
            Font.sansSerif


colorpalette : MyColors -> Color.Color
colorpalette mycolor =
    case mycolor of
        DarkPrimary ->
            Color.rgb 69 90 100

        Primary ->
            Color.rgb 96 125 139

        LightPrimary ->
            Color.rgb 207 216 220

        DarkSecondary ->
            Color.rgb 123 31 162

        Secondary ->
            Color.rgb 156 39 176

        LightSecondary ->
            Color.rgb 225 190 231

        PrimaryText ->
            Color.rgb 53 45 42

        --33 33 33
        SecondaryText ->
            Color.rgb 189 189 189

        White ->
            Color.rgb 255 255 255

        Black ->
            Color.rgb 0 0 0


stylesheet =
    Style.styleSheet
        [ Style.style Background
            [ Color.background (Color.rgb 159 180 190) ]
        , Style.style HeaderText
            [ Color.text (colorpalette LightPrimary)
            , Font.size 36
            , Font.typeface
                [ fontStack Headline
                , fontStack Fallback
                ]
            ]
        , Style.style Header
            [ Color.background (colorpalette DarkPrimary)
            ]
        , Style.style Card
            [ Color.background (colorpalette LightPrimary)
            ]
        , Style.style CardHeader
            [ Color.background (colorpalette DarkPrimary)
            , Color.text (colorpalette LightPrimary)
            , Font.size 28
            , Font.typeface
                [ fontStack Headline
                , fontStack Fallback
                ]
            ]
        , Style.style CardSubheader
            [ Color.text (colorpalette DarkPrimary)
            , Font.size 22
            , Font.typeface
                [ fontStack PrimarySans
                , fontStack Fallback
                ]
            ]
        , Style.style CardText
            [ Color.text (colorpalette DarkPrimary)
            , Font.size 18
            , Font.typeface
                [ fontStack SecondarySans
                , fontStack PrimarySans
                , fontStack Fallback
                ]
            ]
        ]


initialModel : Model
initialModel =
    { name = "Matthew Stevenson, MD"
    , education =
        [ { description = "Doctor of Medicine", location = "University of Texas Southwestern Medical Center, Dallas, TX", dates = "2003 - 2007" }
        , { description = "Post Baccalaureate Studies", location = "University of Texas at Austin, Austin, TX", dates = "2000 - 2001" }
        , { description = "B.A. English", location = "Baylor University, Waco, TX", dates = "1995 - 1999" }
        ]
    , training =
        [ { title = "Fellowship in Clinical Neurophysiology -- EEG Track", location = "University of Michigan, Ann Arbor, MI", dates = "2011 - 2012", description = "Subspecialty training in EEG interpretation and epilepsy management" }
        , { title = "Neurology Residency", location = "University of Texas Southwestern Medical Center, Dallas, TX", dates = "2007 - 2011", description = "Rigorous training in general neurology with broad exposure to all subspecialty fields. Included year of Internal Medicine internship." }
        ]
    , experience =
        [ { position = "General neurology with a focus on epilepsy management and EEG interpretation", location = "Multicare Health Systems, Puyallup, WA", dates = "2016 - present", description = "Joined established neurology division within multispecialty integrated healthcare system to provide EEG interpretation and epilepsy expertise for eastern Pierce County. Continued general neurology practice with roughly 40-50% epilepsy focus." }
        , { position = "General neurology", location = "Clinical Neuroscience, Fort Worth, TX", dates = "2012 - 2016", description = "Joined established small single-specialty group to provide general neurology care. Spearheaded adoption of EHR, including research of software and hardware options." }
        ]
    , publications =
        [ { authors = "Victoria S.S. Wong, Matthew Stevenson, and Linda Selwa", title = "The presentation of seizures and epilepsy in YouTube videos", citation = "Epilepsy and Behavior vol. 27:1 (247-250)." }
        , { authors = "Amer M. Awad and Mathew Stevenson", title = "Isolated Central Nervous System Vasculitis Associated with Antiribonuclear Protein Antibody", citation = "Case Reports in Neurological Medicine, vol. 2011, Article ID 495201, 4 pages, 2011. doi:10.1155/2011/495201." }
        , { title = "Myopathy with Ataxia: case report of nemaline myopathy associated with a cerebellar ataxia syndrome", authors = "", citation = "February 2010 Carrell-Krusen Neuromuscular Symposium Dallas, TX" }
        ]
    , interests = [ "Coding in Ruby, Crystal, Elm, HTML, and CSS", "Science fiction and English literature", "Laughter of my wife and children" ]
    , certifications = [ "ABPN Neurology Certificate: 57880", "WA license: MD60583782", "TX license: P2374", "DEA: ", "BLS Provider exp 11/19" ]
    }


view model =
    Element.viewport stylesheet <|
        (row Header
            [ spacing 15, padding 15, center, width (percent 100), height (px 72) ]
            [ el HeaderText
                [ verticalCenter ]
                (text model.name)
            ]
            |> below
                [ wrappedRow None
                    [ spacing 15, padding 15, width (percent 100), height content ]
                    [ cvCard "Experience" CVExperience model
                    , cvCard "Training" CVTraining model
                    , cvCard "Education" CVEducation model
                    , cvCard "Publications" CVPublications model
                    , wrappedRow None [ spacing 15, width fill ] [ cvCard "Other Interests" CVInterests model, cvCard "Certifications" CVCerts model ]
                    ]
                ]
        )


update model msg =
    model


main =
    Html.beginnerProgram
        { model = initialModel
        , update = update
        , view = view
        }



--, (viewExperience model.experience)
--, (viewTraining model.training)
--, (viewEducation model.education)
--, (viewPublications model.publications)
--, (viewInterests model.interests)
--]
--viewEducation : List Education -> Html.Html msg


cvCard header category model =
    column Card
        [ spacing 10, padding 10, alignLeft, width fill, minWidth (px 400), height fill ]
        [ paragraph CardHeader [ spacing 10, padding 10, width (percent 100) ] [ el None [ padding 10 ] (text header) ]
        , column None
            [ width (percent 100), padding 10 ]
            (List.foldr (++) [] (cvCardBody category model))
        ]


mapFunct category model =
    (\cardcategory -> cvCardBody category)


cvCardBody category model =
    case category of
        CVEducation ->
            List.map
                (\education ->
                    [ paragraph None [ paddingBottom 5 ] [ el CardSubheader [] (text education.description) ]
                    , paragraph None [ paddingBottom 5 ] [ el CardText [] (text education.location) ]
                    , paragraph None [ paddingBottom 20 ] [ el CardText [] (text education.dates) ]
                    ]
                )
                model.education

        CVTraining ->
            List.map
                (\training ->
                    [ paragraph None [ paddingBottom 5 ] [ el CardSubheader [] (text training.title) ]
                    , paragraph None [ paddingBottom 5 ] [ el CardText [] (text training.location) ]
                    , paragraph None [ paddingBottom 5 ] [ el CardText [] (text training.dates) ]
                    , paragraph None [ paddingBottom 20 ] [ el CardText [] (text training.description) ]
                    ]
                )
                model.training

        CVExperience ->
            List.map
                (\experience ->
                    [ paragraph None [ paddingBottom 3 ] [ el CardSubheader [] (text experience.position) ]
                    , paragraph None
                        [ paddingBottom 3 ]
                        [ el CardText [] (text experience.location) ]
                    , paragraph None
                        [ paddingBottom 3 ]
                        [ el CardText [] (text experience.dates) ]
                    , paragraph None
                        [ paddingBottom 20 ]
                        [ el CardText [] (text experience.description)
                        ]
                    ]
                )
                model.experience

        CVPublications ->
            List.map
                (\publications ->
                    [ paragraph None [ paddingBottom 3 ] [ el CardSubheader [] (text publications.title) ]
                    , paragraph None [ paddingBottom 3 ] [ el CardText [] (text publications.authors) ]
                    , paragraph None [ paddingBottom 10 ] [ el CardText [] (text publications.citation) ]
                    ]
                )
                model.publications

        CVInterests ->
            List.map
                (\interests ->
                    [ paragraph None [ paddingBottom 4 ] [ el CardText [] (text interests) ]
                    ]
                )
                model.interests

        CVCerts ->
            List.map
                (\certifications ->
                    [ paragraph None [ paddingBottom 2 ] [ el CardText [] (text certifications) ]
                    ]
                )
                model.certifications


viewEducation education =
    --    column Card
    --[ spacing 10, padding 10, alignLeft, width fill, height fill ]
    --[ paragraph CardHeader [ spacing 10, padding 10, width (percent 100) ] [ el None [ padding 10 ] (text "Education") ]
    --, column None
    --            [ width (percent 100), padding 10 ]
    (List.foldr (++)
        []
        (List.map
            (\education ->
                [ paragraph None [ paddingBottom 5 ] [ el CardSubheader [] (text education.description) ]
                , paragraph None [ paddingBottom 5 ] [ el CardText [] (text education.location) ]
                , paragraph None [ paddingBottom 20 ] [ el CardText [] (text education.dates) ]
                ]
            )
            education
        )
    )



--]


viewTraining training =
    column Card
        [ spacing 10, padding 10, alignLeft, width fill, height fill ]
        [ paragraph CardHeader [ spacing 10, padding 10, width (percent 100) ] [ el None [ padding 10 ] (text "Training") ]
        , column None
            [ width (percent 100), padding 10 ]
            (List.foldr (++)
                []
                (List.map
                    (\training ->
                        [ paragraph None [ paddingBottom 5 ] [ el CardSubheader [] (text training.title) ]
                        , paragraph None [ paddingBottom 5 ] [ el CardText [] (text training.location) ]
                        , paragraph None [ paddingBottom 5 ] [ el CardText [] (text training.dates) ]
                        , paragraph None [ paddingBottom 20 ] [ el CardText [] (text training.description) ]
                        ]
                    )
                    training
                )
            )
        ]


viewExperience experience =
    column Card
        [ spacing 10, padding 10, alignLeft, width fill, height fill ]
        [ paragraph CardHeader [ spacing 10, padding 10, width (percent 100) ] [ el None [] (text "Experience") ]
        , column None
            [ width (percent 100), padding 10 ]
            (List.foldr (++)
                []
                (List.map
                    (\experience ->
                        [ paragraph None [ paddingBottom 3 ] [ el CardSubheader [] (text experience.position) ]
                        , paragraph None
                            [ paddingBottom 3 ]
                            [ el CardText [] (text experience.location) ]
                        , paragraph None
                            [ paddingBottom 3 ]
                            [ el CardText [] (text experience.dates) ]
                        , paragraph None
                            [ paddingBottom 20 ]
                            [ el CardText [] (text experience.description)
                            ]
                        ]
                    )
                    experience
                )
            )
        ]


viewPublications publications =
    column Card
        [ spacing 10, padding 10, alignLeft, width fill, height fill ]
        [ paragraph CardHeader [ spacing 10, padding 10, width (percent 100) ] [ el None [] (text "Publications") ]
        , column None
            [ width (percent 100), padding 10 ]
            (List.foldr (++)
                []
                (List.map
                    (\publications ->
                        [ paragraph None [ paddingBottom 3 ] [ el CardSubheader [] (text publications.title) ]
                        , paragraph None [ paddingBottom 3 ] [ el CardText [] (text publications.authors) ]
                        , paragraph None [ paddingBottom 10 ] [ el CardText [] (text publications.citation) ]
                        ]
                    )
                    publications
                )
            )
        ]


viewInterests interests =
    column Card
        [ spacing 10, padding 10, alignLeft, width fill, height fill ]
        [ paragraph CardHeader [ spacing 10, padding 10, width (percent 100) ] [ el None [] (text "Other Interests") ]
        , column None
            [ width (percent 100), padding 10 ]
            (List.foldr (++)
                []
                (List.map
                    (\interest ->
                        [ paragraph None [ paddingBottom 5 ] [ el CardText [] (text interest) ]
                        ]
                    )
                    interests
                )
            )
        ]


viewCerts certifications =
    column Card
        [ spacing 10, padding 10, alignLeft, width fill, height fill ]
        [ paragraph CardHeader [ spacing 10, padding 10, width (percent 100) ] [ el None [] (text "Certifications") ]
        , column None
            [ width (percent 100), padding 10 ]
            (List.foldr (++)
                []
                (List.map
                    (\certifications ->
                        [ paragraph None [ paddingBottom 5 ] [ el CardText [] (text certifications) ]
                        ]
                    )
                    certifications
                )
            )
        ]



--viewTraining : List Training -> Html msg
--viewTraining training =
--(List.map
--(\training ->
--ul
--[ style [ ( "list-style-type", "none" ) ]
--, Html.Attributes.class "training"
--]
--[ li [] [ text training.title ]
--, li [] [ text training.location ]
--, li [] [ text training.dates ]
--, li [] [ text training.description ]
--]
--)
--training
--)
--viewExperience : List Experience -> Html msg
--viewExperience experience =
--(List.map
--(\experience ->
--ul
--[ style [ ( "list-style-type", "none" ) ]
--]
--[ li [] [ text experience.position ]
--, li [] [ text experience.location ]
--, li [] [ text experience.dates ]
--, li [] [ text experience.description ]
--]
--)
--experience
--)
--viewPublications : List Publications -> Html msg
--viewPublications publications =
--(List.map
--(\publications ->
--ul
--[ style [ ( "list-style-type", "none" ) ]
--]
--[ li [] [ text publications.title ]
--, li [] [ text publications.authors ]
--, li [] [ text publications.citation ]
--]
--)
--publications
--)
--viewInterests : Interests -> Html msg
--viewInterests interests =
--(List.map
--(\interest ->
--ul
--[ style [ ( "list-style-type", "none" ) ]
--]
--[ li [] [ text interest ]
--]
--)
--interests
--)
--update : msg -> Model -> Model
--update msg model =
--model
--main : Program Never Model Model
--main =
--beginnerProgram
--{ model = initialModel
--, view = view
--, update = update
--}
