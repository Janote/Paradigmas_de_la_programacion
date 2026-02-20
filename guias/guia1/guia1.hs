filterMap :: (a -> Maybe b) -> [a] -> [b]
filterMap f xs =
  map (\(Just y) -> y)
    (filter (\x -> case x of
                     Just _  -> True
                     Nothing -> False)
            (map f xs))
