--------------   Print the Board ------------------
--- To print the current board ---
printActualBoard myBoard = do
   putStrLn ((snd (myBoard !! 0)) ++ (snd (myBoard !! 1)) ++ (snd (myBoard !! 2)))
   putStrLn ((snd (myBoard !! 3)) ++ (snd (myBoard !! 4)) ++ (snd (myBoard !! 5)))
   putStrLn ((snd (myBoard !! 6)) ++ (snd (myBoard !! 7)) ++ (snd (myBoard !! 8)))


--- To print the numpad illustration ---
printDemoBoard myBoard = do
    putStrLn ((myBoard !! 0) ++ (myBoard !! 1) ++ (myBoard !! 2))
    putStrLn ((myBoard !! 3) ++ (myBoard !! 4) ++ (myBoard !! 5))
    putStrLn ((myBoard !! 6) ++ (myBoard !! 7) ++ (myBoard !! 8))


----------   Play the Game --------------------------
{-
playGame :: String -> IO()
playGame currentPlayer = do
  -- Board was initially a global variable, but that wasn't updating the way it should have been
  let boardList = [("7", " "), ("8", " "), ("9", " "), ("4", " "), ("5", " "), ("6", " "), ("1", " "), ("2", " "), ("3", " ")]
  --let board = ["-", "-", "-", "-", "-", "-", "-", "-", "-"]
-}
    

------------------ Start the Game ------------------------
main :: IO()
main = do
    putStrLn "Hello and welcome to Tic Tac Toe!"
    putStrLn "\nThe goal of the game is to mark three spaces in a row, either vertically, horizontally, or diagonally"
    putStrLn "\nOne player will use \'x\'as their marker, and the other will use \'o\'"
    putStrLn "\nThe keyboard is laid out like a number pad:"
    printDemoBoard ["7", "8", "9", "4", "5", "6", "1", "2", "3"]
    putStrLn "\n You will start with an empty board\n"
    printActualBoard [("7", "-"), ("8", "-"), ("9", "-"), ("4", "-"), ("5", "-"), ("6", "-"), ("1", "-"), ("2", "-"), ("3", "-")]
    putStrLn "\nTo take your turn, you will enter a number, 1 - 9, corresponding to the space you want to mark. Whoever gets three spaces in a row wins!"
    putStrLn "\n \'x\' will go first: \n"

    --playGame "x"
