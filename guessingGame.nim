import strutils
import std/random
import nigui

# Variable Setup

var randomNum: int = rand(1..100)
var guessCount: int = 0

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

proc applyTurn() =
    if (guessTextArea.text != ""):
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
    guessTextArea.text = ""
    guessTextArea.focus()

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