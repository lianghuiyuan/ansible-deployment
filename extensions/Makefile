REG     = registry.jetio.net/library
IMAGE   = apache/kafka
TAG     = 3.4.0
all:

run: 
	docker run -it ansible:$(TAG) /bin/bash

build:
	docker build -t ansible:$(TAG) .
	docker buildx build --platform linux/amd64 -t $(IMAGE):$(TAG)-amd64  -o type=docker .
	docker buildx build --platform linux/arm64 -t $(IMAGE):$(TAG)-arm64  -o type=docker .

pull:
	docker pull --platform linux/amd64 $(IMAGE):$(TAG)
	docker tag $(IMAGE):$(TAG)  $(REG)/$(IMAGE):$(TAG)-amd64
	docker pull --platform linux/arm64 $(IMAGE):$(TAG)
	docker tag $(IMAGE):$(TAG)  $(REG)/$(IMAGE):$(TAG)-arm64

push: 
	docker tag $(IMAGE):$(TAG)-amd64  $(REG)/$(IMAGE):$(TAG)-amd64
	docker tag $(IMAGE):$(TAG)-arm64  $(REG)/$(IMAGE):$(TAG)-arm64
	docker push $(REG)/$(IMAGE):$(TAG)-amd64
	docker push $(REG)/$(IMAGE):$(TAG)-arm64
	docker manifest create $(REG)/$(IMAGE):$(TAG) $(REG)/$(IMAGE):$(TAG)-amd64 $(REG)/$(IMAGE):$(TAG)-arm64
	docker manifest push $(REG)/$(IMAGE):$(TAG) 
