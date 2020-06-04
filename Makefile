.PHONY: all clean debug init prepare release

all:
	@qbs profile:c6000 config:release
	
init:
	@qbs config --unset profiles.c6000
	
prepare:
	@PROFILE=c6000 titools cgt-c6000 7.4.20 ~/titools

debug:
	@qbs profile:c6000 config:debug
	
release:
	@qbs profile:c6000 config:release

clean:
	@rm -rvf default debug release

