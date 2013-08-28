prodsum :: Int -> Int
prodsum x = prododd x * sumeven x
	where
	prododd, sumeven :: Int -> Int
	prododd x
		| x <= 0 = 1
		| x `mod` 2 == 1 = prododd (x-2) * x			{-recurses whilst multiplying by itself at each recursion-}
		| x `mod` 2 == 0 = prododd (x-2) * (x-1)		{-Does the same as above, just if its even-}
	sumeven x
		| x <= 0 = 0
		| x `mod` 2 == 0 = sumeven (x-2) + x			{-recurses whilst adding to itself at each recursion-}
		| x `mod` 2 == 1 = sumeven (x-2) + (x-1)		{-Does the same as above, just if its off-}

	
rectangle :: Int -> Int -> String
rectangle x y
	| x > 1 = row y ++ rectangle (x-1) y 		{-function row id done on y, and recurses.-}
	| x == 1 = row y							{-the function makes the final row-}
	where
	row :: Int -> String
	row y
		| y > 0 = "*" ++ row (y-1)				{-If y is bigger than 0, it prints a star, and then recurses making (y) amount of stars-}
		| otherwise = "\n"						{-creates a new line-}


flagpattern :: Int -> String
flagpattern x
	| x >= 5 = row x												{-For the function to work x must be bigger than 5-}
	where
	row:: Int -> String
	row y
		| y == x = row1 x ++ row (y-1)							{-row 1 begins and the row function recurses-}	
		| y == 1 = row1 x										{-function row 1 begins-}
		| otherwise = row2 x ++ row (y-1)						{-row2 begins and the row function recurses-}
		where
		row2, row1 :: Int -> String
		row1 y
			| y > 0 = "*" ++ row1 (y-1)       					{-prints a star and recurses row1-}
			| y <= 0 = "\n"                       					{-creates a new row-}
		row2 z
			| z == x = "*" ++ row2 (z-1)
			| z == 1 = "*\n"										{-prints a star and makes a new line-}
			| z == y || (x - z + 1) == y = "*" ++ row2 (z-1)		{-If column number (z) is equal to the row number (y) or if the row number (y) is equal to the total (x) minus column number (z) plus 1-} 				
			| otherwise = " " ++ row2 (z-1)							{-equals the row no, it prints a star-}

			
swapwords :: String -> String -> String -> String
swapwords _ _ [] = []
swapwords w1 w2 xs
	| w1 == take (length w1) xs = w2 ++ swapwords w1 w2 (drop (length w1) xs)	{-swapwords recurses -}  
swapwords w1 w2 (x:xs) = [x] ++ swapwords w1 w2 xs 								{-takes first letter of the string and then recurses swapwords-}


split :: (Eq a) => [a] -> a -> [[a]] 
split xs y
	| head xs == y = split (tail xs) y												{-checks the first element, then recurses split minus the first element-}
	| dropWhile (/=y) xs == [] = [takeWhile (/=y) xs] 								{-if y is in the list, it takes rest of the list and compares it to the empty list-}
	| otherwise = [takeWhile (/=y) xs] ++ (split (tail (dropWhile (/=y) xs)) y)		{-recurses split, with everything after y in the list-}
