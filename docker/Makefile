
.PHONY: all
all: dockerfile.df
	docker build -t pandoc-thesis -f dockerfile.df .



.PHONY: clean
clean:
	docker rmi pandoc-thesis
