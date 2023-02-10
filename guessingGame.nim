import strutils
import std/random
import nigui

# Variable Setup

let randomNum: int = rand(100)
doAssert randomNum in 0..100
var guessCount: int = 0
# Not a great way to do it, but I don't know how to otherwise.
var numbers: array = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0']
var inputIsNum: bool = false
var hasInput: bool = false

# GUI Setup

app.init()

var mainWindow = newWindow("Simple Guessing Game")
mainWindow.height = 300.scaleToDpi
mainWindow.width = 400.scaleToDpi

var rootContainer = newLayoutContainer(Layout_Vertical)
mainWindow.add(rootContainer)
rootContainer.scrollableHeight = 400

var inputContainer = newLayoutContainer(Layout_Horizontal)
rootContainer.add(inputContainer)

var countContainer = newLayoutContainer(Layout_Vertical)
rootContainer.add(countContainer)

var guessTextArea = newTextBox()
inputContainer.add(guessTextArea)

let applyGuessButton = newButton("Guess")
inputContainer.add(applyGuessButton)

var infoLabel = newLabel()
rootContainer.add(infoLabel)

proc gameWon() =
    guessTextArea.hide()
    applyGuessButton.hide()
    var restartButton = newButton("Quit")
    inputContainer.add(restartButton)
    restartButton.focus()

    restartButton.onClick = proc(event: ClickEvent) =
        app.quit()

proc applyTurn() =

    # Main problem with this is it doesn't know when a letter is with a number. It sees the string has a number and accepts it, causing an error.
    for letter in numbers:
        if (guessTextArea.text != ""):
            hasInput = true
            echo "has input"
            if (guessTextArea.text.contains(letter)):
                inputIsNum = true
                echo "true"
                break
            elif (guessTextArea.text.contains(letter) == false):
                inputIsNum = false
                echo letter

    guessTextArea.focus()
    if (inputIsNum and hasInput):
        guessCount += 1
        var countText: string
        if (guessTextArea.text.parseInt() > randomNum):
            countText = ", too large!"
        elif (guessTextArea.text.parseInt() < randomNum):
            countText = ", too small!"
        else:
            countText = ", correct!"
        rootContainer.add(newLabel(guessTextArea.text & countText))
        if (guessTextArea.text.parseInt() == randomNum):
            var pluralText: string
            if (guessCount > 1):
                pluralText = " times!"
            else:
                pluralText = " time!"
            infoLabel.text = "Well done! You guessed " & $guessCount & pluralText
            gameWon()
    elif (hasInput == false):
        mainWindow.alert("Enter a number")
    elif (inputIsNum == false):
        mainWindow.alert("Only numbers are allowed")
    guessTextArea.text = ""
    hasInput = false

applyGuessButton.onClick = proc(event: ClickEvent) = applyTurn()

guessTextArea.onKeyDown = proc(event: KeyboardEvent) = 
    if event.key == Key_Return:
        applyTurn()

mainWindow.show()
guessTextArea.focus()
app.run()

# Old CLI game
#[
while (true):
    echo "Guess the number:"
    let guessedNum = readLine(stdin).parseInt()
    if (guessedNum > randomNum):
        echo "Too large"
        guessCount += 1
    elif (guessedNum < randomNum):
        echo "Too small"
        guessCount += 1
    else:
        guessCount += 1
        echo "Well done! You guessed ", guessCount,
            if (guessCount>1):
                " times!"
            else:
                " time!"
        echo "Would you like to play again? y/n"
        var playAgain = readLine(stdin)
        if playAgain == "y":
            randomNum = rand(1..100)
            guessCount = 0
        else:
            break
]#