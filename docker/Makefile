# Author: Carsten Gips <carsten.gips@fh-bielefeld.de>
# Copyright: (c) 2019 Carsten Gips
# License: MIT



.PHONY: all
all: dockerfile.df
	docker build -t pandoc-thesis -f dockerfile.df .



.PHONY: clean
clean:
	docker rmi pandoc-thesis
