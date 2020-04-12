# Life
Game of life implementation. Made with love, with LÖVE.

## What is this?
- The game of life is an interesting take on how organisms (and communities of organisms) live and die
- https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life
- Rest in Peace John Conway :cry:

## Dependencies
- The game was developed on LÖVE 11.1, but it should work on older versions as well
- A creative mind and a heart full of love
- Also written in Lua

## Controls
- the game starts in the `paused` mode, where you can `mouse click` cells to make them live or die
- when the game is not in the `paused` mode, the game world will automatically begin evolving. To toggle `paused` mode, press `space`
- automatic evolution happens every set amount of ticks. To speed up evolution, `scroll down` on the mouse wheel. Similarly, to slow down the evolution process, `scroll up`
- take screenshots by pressing `p`. Screenshots will be saved in your local directory depending on your operating system (see this link for more information: https://love2d.org/wiki/love.filesystem)
- press `esc` to quit the game

## Details
- The board is 1000 px wide and 600 px tall
- The actual tiles are 10x10 pixels meaning there are 100x60 tiles
- Music playing in the background is based on the # of live tiles at any given moment

jryzkns 2018
