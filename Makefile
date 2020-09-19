.DEFAULT_GOAL := all

SHELL := /bin/bash

makefile := $(abspath $(lastword $(MAKEFILE_LIST)))
makefile_dir := $(dir $(makefile))

.PHONY: all
all: ## output targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(makefile) | awk 'BEGIN { FS = ":.*?## " }; { printf "\033[36m%-30s\033[0m %s\n", $$1, $$2 }'

.PHONY: build
build: name := sasaplus1/box
build: ## build user-data.img
	DOCKER_BUILTKIT=1 docker build -t $(name) .
	docker run --rm -v "$$PWD:/root" $(name) user-data.img user-data
	cp user-data.img vagrant/user-data.iso
	mv user-data.img qemu/
