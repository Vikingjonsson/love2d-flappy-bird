run:
	love .

build:
	echo "build"
	zip -9 -r ./builds/Game.love assets/ src/ lib/ main.lua

play:
	echo "play"
	love ./builds/Game.love
