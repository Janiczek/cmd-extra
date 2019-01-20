module Cmd.Extra exposing (withNoCmd, withCmd, withCmds, addCmd, addCmds, andThen)

{-| A library providing pipeline-friendly Cmd operators.


# Cmds

@docs withNoCmd, withCmd, withCmds, addCmd, addCmds, andThen

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

    ( model, cmd )
        |> addCmd ping

-}
addCmd : Cmd msg -> ( model, Cmd msg ) -> ( model, Cmd msg )
addCmd cmd ( model, oldCmd ) =
    ( model, Cmd.batch [ oldCmd, cmd ] )


{-| Adds new `Cmd`s to an existing model-Cmd tuple.

    ( model, cmd )
        |> addCmds [ ping 1, ping 2 ]

-}
addCmds : List (Cmd msg) -> ( model, Cmd msg ) -> ( model, Cmd msg )
addCmds cmds ( model, oldCmd ) =
    ( model, Cmd.batch (oldCmd :: cmds) )


{-| Allows your function that works on `Model` to work on `(Model, Cmd Msg)`.

    doFoo : Model -> (Model, Cmd Msg)
    doBar : Model -> (Model, Cmd Msg)

    model
        |> doFoo
        -- we have `(Model, Cmd Msg)` now, but `doBar` needs a `Model`
        -- so we use...
        |> andThen doBar

-}
andThen : (model -> ( model, Cmd msg )) -> ( model, Cmd msg ) -> ( model, Cmd msg )
andThen fn ( model, cmd ) =
    let
        ( newModel, newCmd ) =
            fn model
    in
    ( newModel
    , Cmd.batch [ cmd, newCmd ]
    )
