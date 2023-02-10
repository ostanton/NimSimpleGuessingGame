# NimSimpleGuessingGame
GUI-based simple guessing game

A very simple number guessing game written in [Nim](https://nim-lang.org/) using [NiGui](https://github.com/simonkrauter/NiGui). I started learning Nim today, and made this the same day. Bugs include:
- Answer is always 88 (`rand()` function messing up, will look into this)
- Scrolling scrolls the whole window contents instead of submitted answers. There is no documentation of NiGui yet so I have no idea how to change this.
- No replay button. As far as I know, NiGui doesn't support clearing containers' children, so if I were to make a replay button it would just restart the program.
- Error when entering non-numbers into entry box.

Please report any more bugs!

There are may ways to improve this I know, but it's my first GUI application outside Unreal Engine, and my first proper code application, so cut me some slack!

If you want to compile it yourself, you need [NiGui](https://github.com/simonkrauter/NiGui) (sadly there is no documentation I could find except examples)
