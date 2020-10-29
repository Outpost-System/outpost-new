.PHONY: test clean

build/outpost.mpackage: mfile $(wildcard src/**/*.lua) $(wildcard src/**/*.xml)
	muddle

test:
	busted

all: test build/outpost.mpackage

clean:
	rm build/outpost.mpackage