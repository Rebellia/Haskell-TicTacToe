{-
Unfortunately, this code does not compile. There are several "can't match type" errors that need to be debugged. I did test the individual concepts ("Print the Board", "Play the Game", "Check the Winner") on their own prior to combining all of them together, but I did not leave myself enough time for that debugging process. Even so, I learned a lot from this experience. 

Fun fact: The board used to be a global variable that I would try to update from various functions. (Spoiler: those update attempts were not successful.


Some of my function declarations, [functionName] :: [input] -> [output], were causing errors and I ran out of time to figure out why so I chose to comment them out so that I could at least remember what my inputs and outputs would be 
-}

--------------   Print the Board ------------------
--- To print the current board as a 3x3 grid---

printActualBoard :: [(String, String)] -> IO()
printActualBoard myBoard = do
   putStrLn("\n Here is the current board")
   putStrLn ((snd (myBoard !! 0)) ++ (snd (myBoard !! 1)) ++ (snd (myBoard !! 2)))
   putStrLn ((snd (myBoard !! 3)) ++ (snd (myBoard !! 4)) ++ (snd (myBoard !! 5)))
   putStrLn ((snd (myBoard !! 6)) ++ (snd (myBoard !! 7)) ++ (snd (myBoard !! 8)))


--- To print the numpad illustration ---
--- I want players to understand where their input will be placed ---
printDemoBoard :: IO()
printDemoBoard = do
    let myBoard = ["7", "8", "9", "4", "5", "6", "1", "2", "3"]
    putStrLn "\nThe game board is laid out like a number pad:"
    putStrLn ((myBoard !! 0) ++ (myBoard !! 1) ++ (myBoard !! 2))
    putStrLn ((myBoard !! 3) ++ (myBoard !! 4) ++ (myBoard !! 5))
    putStrLn ((myBoard !! 6) ++ (myBoard !! 7) ++ (myBoard !! 8))


----------   Play the Game --------------------------


playGame :: [Char] -> IO()
playGame currentPlayer = do
   -- Board was initially a global variable, but that wasn't updating the way it should have been. It is now a local variable that will be properly updated.
   let board = [("7", "-"), ("8", "-"), ("9", "-"), ("4", "-"), ("5", "-"), ("6", "-"), ("1", "-"), ("2", "-"), ("3", "-")]
  
   takeTurn board currentPlayer


takeTurn :: [([Char], [Char])] -> String -> IO()
takeTurn currentBoard currentPlayer = do
  --Initially board was in here, but I realized that it would constantly be overwritten if I did that. So the board was moved to an overarching helper function.
  putStrLn "\n This is the currentBoard: "
  printActualBoard currentBoard
  

{-
  Grab the current board
  If it's full without a winner, then it's a tie. Game over.
  If player X has won, then congrats to them. Game over.
  If player Y has won, then congrats to them. Game over.


  Otherwise, the current player may pick a space
  As long as that space is valid they can mark the space
  Switch the player and repeat
-}
  if isTie currentBoard
  then
      putStrLn "It's a tie!"
  else if hasWon currentBoard currentPlayer
      then do putStrLn ("\nPlayer " ++ currentPlayer ++ " won!")
  else if hasWon currentBoard (changePlayer currentPlayer)
      then do putStrLn ("\nPlayer " ++ (changePlayer currentPlayer) ++ " won!")
  else do
      putStrLn "Please pick a number, 1-9"
      chosenNumber <- getLine

      if isValid chosenNumber currentBoard
      then do
        let updatedBoard = markSpace currentBoard chosenNumber currentPlayer
        putStrLn ("\n Player " ++ currentPlayer ++ "has marked a space")
        takeTurn updatedBoard (changePlayer currentPlayer)
      else
        print ("Invlaid input. Please try again")
        takeTurn currentBoard currentPlayer

  

changePlayer :: String -> String
changePlayer currentPlayer = 
    if currentPlayer == "x"
    then "o"
    else "x"


--markSpace :: [(String, String)] -> String -> String -> [(String, String)]
{-
markSpace myBoard chosenSpace currentPlayer = do
    map(\ x -> if x == (chosenSpace, ' ') then (chosenSpace, 'x') else x) myBoard -}
markSpace myBoard chosenSpace currentPlayer = 
    map(\ x -> if x == (chosenSpace, "-") then (chosenSpace, currentPlayer) else x) myBoard

------------ Gameplay Helper Functions -------------------------
--isValid :: (String, String) -> Bool
isValid space myBoard = elem (space, "-") myBoard

--anyEmpty:: [(String, String)] -> Bool
anyEmpty myBoard = do
    let count = 1
    if elem (count, "-") myBoard && count <= 9
    then True
    else do
       anyEmpty elem (count+1, "-")


--- Checking Winner ---
{-
    I am confident that there is a better, more effcient way to check for 3 characters in a row in a 3x3 grid. This is a brute force solution I've gone with for now and if I have time later on, then I will refactor it.
-}
checkSame :: [(String, String)] -> String -> String -> String -> Bool
checkSame currentPlayer elem1 elem2 elem3 =
    -- If any are empty, no winner from this combo
    if elem1 == "-" || elem2 == "-" || elem3 == "-"
    then False
    else
        if (==) elem1 elem2 && (==) elem1 elem3 && (==) elem1 currentPlayer
        then True
        else False



grabChars currentPlayer myBoard index1 index2 index3 =
    let elem1 = snd (myBoard !! index1)
        elem2 = snd (myBoard !! index2)
        elem3 = snd (myBoard !! index3)
    in checkSame currentPlayer elem1 elem2 elem3


isTie :: [(String, String)] -> Bool
isTie myBoard =
    if (anyEmpty myBoard == False) && (hasWon myBoard "x" == False) && (hasWon myBoard "o" == False)
    then True
    else False

{-
    There is probably a mathematical solution to getting the 3 characters needed for comparison, but since there are only eight possible winning
    combos, I felt comfortable just writing all eight of them out. If I have time, I will come back to refactor.
-}
hasWon :: [(String, String)] -> String -> Bool
hasWon myBoard currentPlayer =
   -- horizontals
   if grabChars currentPlayer myBoard 0 1 2
      then True
   else if grabChars currentPlayer myBoard 3 4 5
      then True
   else if grabChars currentPlayer myBoard 6 7 8
      then True
   -- verticals
   else if grabChars currentPlayer myBoard 1 4 7
      then True
   else if grabChars currentPlayer myBoard 2 5 8
      then True
   else if grabChars currentPlayer myBoard 3 6 9
      then True
   -- diagonals
   else if grabChars currentPlayer myBoard 1 5 9
      then True
   else if grabChars currentPlayer myBoard 3 5 7
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

    playGame "x"
