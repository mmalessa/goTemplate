APP_NAME = gotemplate
APP_HOME = github.com/githubuser/$(APP_NAME)

BASE_GO_IMAGE = golang:1.17.6-alpine3.15
BASE_TARGET_IMAGE = alpine:3.15

IMAGE_DEV = $(APP_NAME)-dev

DOCKERFILE_DEV = .docker/dev/Dockerfile


CGO_ENABLED = 0 # statically linked = 0
TARGETOS=linux
ifeq ($(OS),Windows_NT) 
    TARGETOS := Windows
else
    TARGETOS := $(shell sh -c 'uname 2>/dev/null || echo Unknown' | tr '[:upper:]' '[:lower:]')
endif
TARGETARCH = amd64

.DEFAULT_GOAL = help
PID = /tmp/serving.pid
DEVELOPER_UID     ?= $(shell id -u)
#-----------------------------------------------------------------------------------------------------------------------
ARG := $(word 2, $(MAKECMDGOALS))
%:
	@:
#-----------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------

help: ## Outputs this help screen
	@grep -E '(^[a-zA-Z0-9_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}{printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

build: build-image ## Alias for 'build-image'

build-image: ## Build dev image
	@docker build 											\
	    -t $(IMAGE_DEV)										\
		--build-arg BASE_GO_IMAGE=$(BASE_GO_IMAGE)			\
		--build-arg DEVELOPER_UID=$(DEVELOPER_UID)			\
		--build-arg APP_HOME=$(APP_HOME)					\
		-f $(DOCKERFILE_DEV)								\
		.
up: ## Start application dev container
	@cd .docker && \
	COMPOSE_PROJECT_NAME=$(APP_NAME) \
	IMAGE_DEV=$(IMAGE_DEV) \
	APP_NAME=$(APP_NAME) \
	APP_HOME=$(APP_HOME) \
	docker-compose up -d

down: ## Remove application dev container
	@cd .docker && \
	COMPOSE_PROJECT_NAME=$(APP_NAME) \
	IMAGE_DEV=$(IMAGE_DEV) \
	APP_NAME=$(APP_NAME) \
	APP_HOME=$(APP_HOME) \
	docker-compose down

console: ## Enter application dev container
	@docker exec -it $(APP_NAME)-dev bash

go: go-build ## Alias for 'go-build'

go-build: ## Build dev application (go build)	
	@go mod tidy
	@env CGO_ENABLED=${CGO_ENABLED} GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -ldflags "-X main.env=dev" -o bin/${APP_NAME} ./

clean: ## Clean bin/
	@rm -rf bin/${APP_NAME}
