run:
	love .

build:
	echo "build"
	zip -9 -r ./builds/Game.love .

play:
	echo "play"
	love ./builds/Game.love
