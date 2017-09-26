module Cmd.Extra exposing (..)

{-| A library providing pipeline-friendly Cmd operators.


# Cmds

@docs withNoCmd, withCmd, withCmds, addCmd

-}


{-| Wraps the model with `Cmd.none`.

    init : ( Model, Cmd Msg )
    init =
        myModel
            |> withNoCmd

-}
withNoCmd : model -> ( model, Cmd msg )
withNoCmd model =
    ( model, Cmd.none )


{-| Wraps the model with given `Cmd`.

    incrementAndPing : Model -> ( Model, Cmd Msg )
    incrementAndPing model =
        { model | counter = model.counter + 1 }
            |> withCmd ping

-}
withCmd : Cmd msg -> model -> ( model, Cmd msg )
withCmd cmd model =
    ( model, cmd )


{-| Wraps the model with given `Cmd`s.

    incrementAndPingTwice : Model -> ( Model, Cmd Msg )
    incrementAndPingTwice model =
        { model | counter = model.counter + 1 }
            |> withCmds [ ping 1, ping 2 ]

-}
withCmds : List (Cmd msg) -> model -> ( model, Cmd msg )
withCmds cmds model =
    ( model, Cmd.batch cmds )


{-| Adds a new `Cmd` to an existing model-Cmd tuple.
-}
addCmd : Cmd msg -> ( model, Cmd msg ) -> ( model, Cmd msg )
addCmd cmd ( model, oldCmd ) =
    ( model, Cmd.batch [ oldCmd, cmd ] )
