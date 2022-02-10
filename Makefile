DOCKER      = docker
DOCKERFILE  = Dockerfile
PORT        = 8080
TAG         = alpine-vnc
LINT_IGNORE = "DL3007"
GRADLEW     = ./gradlew
PACK        = pack
BUILDER_CNF = ./builder/builder.toml
BUILDER_IMG = my-builder:bionic
CONTAINER   = k3d-on-docker_dind_1
VERSION			= 3.10

all: hadolint build

hadolint:
	$(DOCKER) run --rm -i hadolint/hadolint hadolint - --ignore ${LINT_IGNORE} < $(DOCKERFILE)

build:
	$(DOCKER) buildx build --platform linux/amd64 -t $(TAG) --load .

run:
	$(DOCKER) run -d --name itotest -p 5900:5900 $(TAG)

clean:
	$(DOCKER) rm -f $(TAG)
	$(DOCKER) container prune -f

