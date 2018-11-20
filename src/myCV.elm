module MyCV exposing (..)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input
import Element.Lazy


type MyFonts
    = Headline
    | PrimarySans
    | SecondarySans
    | PrimarySerif
    | SecondarySerif
    | Fallback


type ColorPalette
    = Primary
    | PrimaryDark
    | PrimaryLight
    | Secondary
    | SecondaryDark
    | SecondaryLight
    | Highlight
    | Alert
    | White
    | Black


fontStack : MyFonts -> Font.Font
fontStack font =
    case font of
        Headline ->
            Font.external { url = "https://fonts.googleapis.com/css?family=Dosis", name = "dosis" }

        PrimarySans ->
            Font.external { url = "https://fonts.googleapis.com/css?family=Roboto", name = "roboto" }

        SecondarySans ->
            Font.sansSerif

        PrimarySerif ->
            Font.external { url = "https://fonts.googleapis.com/css?family=Esteban", name = "esteban" }

        SecondarySerif ->
            Font.serif

        Fallback ->
            Font.sansSerif


colorPalette : ColorPalette -> Color
colorPalette color =
    case color of
        Primary ->
            rgba255 100 100 100 1

        --96 125 139 1
        PrimaryDark ->
            rgba255 69 90 100 1

        PrimaryLight ->
            rgba255 200 200 200 1

        --207 216 220 1
        Secondary ->
            rgba255 200 100 50 1

        --156 39 176 1
        SecondaryDark ->
            rgba255 123 31 162 1

        SecondaryLight ->
            rgba255 213 192 182 1

        --225 190 231 1
        Highlight ->
            rgba 254 128 25 1

        Alert ->
            rgba 207 80 75 1

        White ->
            rgba 233 236 250 1

        Black ->
            rgba 0 0 0 1


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


myInfo : Model
myInfo =
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
    , interests = [ "Coding in Ruby, Rust, Elm, HTML, & CSS", "Science fiction and English literature", "Laughter of my wife and children" ]
    , certifications = [ "ABPN Neurology Certified: 2012", "WA license: unrestricted", "TX license: unrestricted", "DEA: unrestricted", "BLS Provider exp 11/19", "License numbers upon request." ]
    }


type CVCategory
    = CVExperience
    | CVEducation
    | CVTraining
    | CVPublications
    | CVInterests
    | CVCerts


type Style
    = Header
    | Subheader
    | MainText
    | SubText


styling : Style -> List (Attribute msg)
styling style =
    case style of
        Header ->
            [ Font.color (colorPalette PrimaryLight)
            , Font.size 36
            , Font.family
                [ fontStack Headline
                , fontStack Fallback
                ]
            ]

        Subheader ->
            [ Font.color (colorPalette PrimaryLight), Font.size 22, Font.heavy, Font.family [ fontStack PrimarySans, fontStack Headline, fontStack Fallback ] ]

        MainText ->
            [ Font.color (colorPalette PrimaryLight), Font.size 18, Font.medium, Font.family [ fontStack PrimarySans, fontStack Fallback ] ]

        SubText ->
            [ Font.color (colorPalette PrimaryLight), Font.size 16, Font.light, Font.family [ fontStack PrimarySans, fontStack Fallback ] ]


edges =
    { top = 0, right = 0, left = 0, bottom = 0 }


mapFunct category model =
    (\cardcategory -> cvCardBody category)


cvCardBody category model =
    let
        list =
            case category of
                CVEducation ->
                    (List.map
                        (\education ->
                            [ paragraph [ paddingEach { edges | bottom = 5 } ] [ el (styling Subheader) (text education.description) ]
                            , paragraph [ paddingEach { edges | bottom = 5 } ] [ el (styling MainText) (text education.location) ]
                            , paragraph [ paddingEach { edges | bottom = 20 } ] [ el (styling SubText) (text education.dates) ]
                            ]
                        )
                        model.education
                    )

                CVTraining ->
                    (List.map
                        (\training ->
                            [ paragraph [ paddingEach { edges | bottom = 5 } ] [ el (styling Subheader) (text training.title) ]
                            , paragraph [ paddingEach { edges | bottom = 5 } ] [ el (styling MainText) (text training.location) ]
                            , paragraph [ paddingEach { edges | bottom = 5 } ] [ el (styling SubText) (text training.dates) ]
                            , paragraph [ paddingEach { edges | bottom = 20 } ] [ el (styling MainText) (text training.description) ]
                            ]
                        )
                        model.training
                    )

                CVExperience ->
                    (List.map
                        (\experience ->
                            [ paragraph [ padding 3 ] [ el (styling Subheader) (text experience.position) ]
                            , paragraph
                                [ padding 3 ]
                                [ el (styling SubText) (text experience.location) ]
                            , paragraph
                                [ padding 3 ]
                                [ el (styling SubText) (text experience.dates) ]
                            , paragraph
                                [ paddingEach { top = 5, bottom = 20, left = 3, right = 3 } ]
                                [ el (styling MainText) (text experience.description)
                                ]
                            ]
                        )
                        model.experience
                    )

                CVPublications ->
                    (List.map
                        (\publications ->
                            [ paragraph [ padding 3 ] [ el [] (text publications.title) ]
                            , paragraph [ padding 3 ] [ el [] (text publications.authors) ]
                            , paragraph [ padding 10 ] [ el [] (text publications.citation) ]
                            ]
                        )
                        model.publications
                    )

                CVInterests ->
                    (List.map
                        (\interests ->
                            [ paragraph [ padding 4 ] [ el (styling MainText) (text interests) ]
                            ]
                        )
                        model.interests
                    )

                CVCerts ->
                    (List.map
                        (\certifications ->
                            [ paragraph [ width (px 256), centerX ] [ el (styling MainText) (text certifications) ]
                            ]
                        )
                        model.certifications
                    )
    in
        column [ centerX, width (fill |> maximum 380), height fill, padding 20 ] (List.foldr (++) [] list)


headerBox name tl tr br bl =
    Element.row [ Border.roundEach { topLeft = tl, topRight = tr, bottomRight = br, bottomLeft = bl }, width (fill), height (px 72), centerX, alignTop, Background.color (colorPalette Primary) ]
        [ Element.el
            (List.append
                [ centerX
                , centerY
                ]
                (styling Header)
            )
            (text name)
        ]


cvCard header tl tr br bl category =
    (column [ width (fill |> minimum 400), height fill, spacing 10, Border.width 10, Border.color (colorPalette PrimaryLight), Background.color (colorPalette Secondary), Border.roundEach { topLeft = tl, topRight = tr + 10, bottomLeft = bl + 10, bottomRight = br } ]
        [ (headerBox header tl tr br bl)
        , cvCardBody category myInfo
        ]
    )


main =
    layout [ Background.color (colorPalette PrimaryLight) ] <|
        (column
            [ width fill, spacing 10 ]
            [ (headerBox
                myInfo.name
                0
                0
                0
                0
              )
            , (wrappedRow [ height fill, paddingEach { top = 10, left = 20, right = 20, bottom = 0 }, centerX ] [ (cvCard "Education" 0 20 0 20 CVEducation), (cvCard "Training" 0 20 0 20 CVTraining), (cvCard "Experience" 0 20 0 20 CVExperience) ])
            , (wrappedRow [ width (fill |> maximum 1260), paddingEach { edges | bottom = 30, left = 30, right = 30 }, centerX ] [ cvCard "Other Interests" 0 20 0 20 CVInterests, cvCard "Certifications" 0 20 0 20 CVCerts ])
            ]
        )
