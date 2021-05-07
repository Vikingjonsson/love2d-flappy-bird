RELEASE_DIR = './releases'
RESOURCE_PATH = 'game.app/Contents/Resources'
BUILD_NUMBER := $(words $(wildcard ./builds/*.love))
LATEST_BUILD := $(shell echo ${BUILD_NUMBER}-1 | bc)
LATEST_BUILD_PATH = './builds/build_$(LATEST_BUILD).love'


dev:
	echo "dev"
	love .

build:
	echo "build $(BUILD_NUMBER)"
	mkdir -p builds
	zip -9 -r ./builds/build_$(BUILD_NUMBER).love assets/ src/ lib/ main.lua

run:
	echo "play $(LATEST_BUILD)"
	love $(LATEST_BUILD_PATH)

app:
	echo "app"
	cp -r $(RELEASE_DIR)/love.app $(RELEASE_DIR)/game.app
	cp -r $(LATEST_BUILD_PATH) ./$(RELEASE_DIR)/$(RESOURCE_PATH)
