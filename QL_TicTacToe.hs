{-
  This section of code is all about printing the board.
  It's ugly, and could be a lot better
-}

boardList = [("7", "-"), ("8", "-"), ("9", "-"), ("4", "-"), ("5", "-"), ("6", "-"), ("1", "-"), ("2", "-"), ("3", "-")]

-------------    Printing the board   -------------------------
printBoard myBoard = do
    putStrLn "Here is the current board:"
    print (print3 myBoard)
    print (print3 (remove3 myBoard))
    print(print3 (remove3 (remove3 myBoard)))

--prints the first 3 elements of the list
print3 myRow = myPrintChars (take 3 myRow)
--print3 myRow = take 3 myRow

--remove3 :: [] -> []
remove3 myList = drop 3 myList


myPrintChars row = snd (row !! 0) ++ snd (row !! 1) ++ snd (row !! 2) 

main = do
    putStrLn "Hello and welcome to TicTacToe!"
    printBoard boardList

    
