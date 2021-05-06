dev:
	love .

BUILD_NUMBER := $(words $(wildcard ./builds/*.love))
build:
	echo "Build $(BUILD_NUMBER)"
	mkdir -p builds
	zip -9 -r ./builds/build_$(BUILD_NUMBER).love assets/ src/ lib/ main.lua


LATEST_BUILD := $(shell echo ${BUILD_NUMBER}-1 | bc)
run:
	echo "play $(LATEST_BUILD)"
	love ./builds/build_$(LATEST_BUILD).love
