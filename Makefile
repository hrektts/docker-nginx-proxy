all: build

build:
	@docker build --tag=hrektts/nginx-proxy:latest .

release: build
	@docker build --tag=hrektts/nginx-proxy:$(shell cat VERSION) .
