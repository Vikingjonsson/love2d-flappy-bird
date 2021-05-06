dev:
	love .

build:
	echo "build"
	zip -9 -r ./builds/Game.love assets/ src/ lib/ main.lua

run:
	echo "play"
	love ./builds/Game.love
