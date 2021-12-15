{-
   Overall this was a good experience. I realized that I need to change how I think about my code. For example, the board used to be a global variable that I would try to update from various functions. Then I would be surprised that this global variable was never updated.


Some of my function declarations, [functionName] :: [input] -> [output], were causing errors and I rant out of time to figure out why so I chose to comment them out so that I could remember what my inputs and outputs would be 
-}

--------------   Print the Board ------------------
--- To print the current board ---

--printActualBoard [String] -> IO()
printActualBoard myBoard = do
   putStrLn("\n Here is the current board")
   putStrLn ((snd (myBoard !! 0)) ++ (snd (myBoard !! 1)) ++ (snd (myBoard !! 2)))
   putStrLn ((snd (myBoard !! 3)) ++ (snd (myBoard !! 4)) ++ (snd (myBoard !! 5)))
   putStrLn ((snd (myBoard !! 6)) ++ (snd (myBoard !! 7)) ++ (snd (myBoard !! 8)))


--- To print the numpad illustration ---

--printDemoBoard [String] -> IO()
printDemoBoard = do
    let myBoard = ["7", "8", "9", "4", "5", "6", "1", "2", "3"]
    putStrLn "\nThe game board is laid out like a number pad:"
    putStrLn ((myBoard !! 0) ++ (myBoard !! 1) ++ (myBoard !! 2))
    putStrLn ((myBoard !! 3) ++ (myBoard !! 4) ++ (myBoard !! 5))
    putStrLn ((myBoard !! 6) ++ (myBoard !! 7) ++ (myBoard !! 8))


----------   Play the Game --------------------------


--playGame :: -> IO()
playGame currentPlayer = do
   -- Board was initially a global variable, but that wasn't updating the way it should have been
   let board = [("7", "-"), ("8", "-"), ("9", "-"), ("4", "-"), ("5", "-"), ("6", "-"), ("1", "-"), ("2", "-"), ("3", "-")]
  
   takeTurn board currentPlayer


--takeTurn :: [String] -> String -> IO()
takeTurn currentBoard currentPlayer = do
  --Initially board was in here, but I realized that it would constantly be overwritten if I did that
  putStrLn "\n This is the currentBoard: "
  printActualBoard currentBoard
  
  -- Check if the board is full
  if isTie currentBoard
  then
      putStrLn "It's a tie!"
  else do
      putStrLn "The board is full so there is a tie!"

  


--markSpace :: [(String, String)] -> String -> String -> [(String, String)]
markSpace myBoard currentPlayer chosenSpace = do
    map(\ x -> if x == (number, ' ') then (number, 'x') else x) boardList

------------ Gameplay Helper Functions -------------------------
--isValid :: (String, String) -> Bool
isValid space myBoard = elem (number, "-") simpleList

--anyEmpty:: [(String, String)] -> Bool
anyEmpty myBoard = do
    let count = 0 && count <= 9
    if elem (count, "-") myBoard
    then True
    else do
       anyEmpty elem (count+1, "-")

checkSame elem1 elem2 elem3 =
    -- If any are empty, no winner from this combo
    if elem1 == "-" || elem2 == "-" || elem3 == "-"
    then False
    else
        if (==) elem1 elem2 && (==) elem1 elem3
        then True
        else False

grabChars myBoard index1 index2 index3 =
    let elem1 = snd (myList !! index1)
        elem2 = snd (myList !! index2)
        elem3 = snd (myList !! index3)
    in checkSame elem1 elem2 elem3


--isTie :: [String] -> Bool
isTie myBoard =
    if (anyEmpty myBoard == False) && (hasWon myBoard "x" == False) && (hasWon myBoard "y" == False)
    then True
    else False

hasWon myBoard currentPlayer =
   -- horizontals
   if grabChars myList 0 1 2
      then True
   else if grabChars myList 3 4 5
      then True
   else if grabChars myList 6 7 8
      then True
   -- verticals
   else if grabChars myList 1 4 7
      then True
   else if grabChars myList 2 5 8
      then True
   else if grabChars myList 3 6 9
      then True
   -- diagonals
   else if grabChars myList 1 5 9
      then True
   else if grabChars myList 3 5 7
      then True
   else False
   

  

  
    

------------------ Start the Game ------------------------
main :: IO()
main = do
    putStrLn "Hello and welcome to Tic Tac Toe!"
    putStrLn "\nThe goal of the game is to mark three spaces in a row, either vertically, horizontally, or diagonally"
    putStrLn "\nOne player will use \'x\'as their marker, and the other will use \'o\'"
    printDemoBoard
    putStrLn "\n You will start with an empty board\n"
    printActualBoard [("7", "-"), ("8", "-"), ("9", "-"), ("4", "-"), ("5", "-"), ("6", "-"), ("1", "-"), ("2", "-"), ("3", "-")]
    putStrLn "\nTo take your turn, you will enter a number, 1 - 9, corresponding to the space you want to mark. Whoever gets three spaces in a row wins!"
    putStrLn "\n \'x\' will go first: \n"

    --playGame "x"
