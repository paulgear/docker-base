REGISTRY=
LOGIN=paulgear
REPO=base

default: push

build:
	docker build -t $(REGISTRY)$(LOGIN)/$(REPO) .

push:	build
	docker push $(REGISTRY)$(LOGIN)/$(REPO)

run:	build
	docker run --rm -ti $(REGISTRY)$(LOGIN)/$(REPO)
