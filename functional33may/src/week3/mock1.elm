module Week3.Mock1 exposing (..)


minimumGain: List Float -> Maybe Float
minimumGain list =
    List.foldr
     (\n minMaybe ->
        case minMaybe of
            Just min ->
                if n > 0 && n < min then
                    Just n
                else
                    minMaybe
            Nothing ->
                if n > 0 then
                    Just n
                else
                    minMaybe
     ) Nothing list