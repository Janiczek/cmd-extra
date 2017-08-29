# Cmd.Extra

Instead of

```elm
init : ( Model, Cmd Msg )
init =
    ( myModel, Cmd.none )
```

write

```elm
init : ( Model, Cmd Msg )
init =
    myModel
        |> withNoCmd
```

----

And instead of

```elm
incrementAndPing : Model -> ( Model, Cmd Msg )
incrementAndPing model =
    ( { model | counter = model.counter + 1 }
    , ping
    )
```

write

```elm
incrementAndPing : Model -> ( Model, Cmd Msg )
incrementAndPing model =
    { model | counter = model.counter + 1 }
        |> withCmd ping
```
