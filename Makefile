all: build

build:
	@docker build --tag=hrektts/nginx-proxy:latest .

release: build
	@docker build --tag=hrektts/nginx-proxy:$(shell cat VERSION) .

.PHONY: test
test:
	@docker build -t hrektts/nginx-proxy:bats .
	@make -C test/backend
	bats test
