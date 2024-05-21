IMAGE_NAME ?= kube-exercise
TAG ?= $$TAG

.PHONY: all

all: docker-build-api docker-build-data docker-build-frontend

docker-login:
	@echo "Login to docker"
	@docker login -u $(DOCKER_USER) -p $(DOCKER_PASS)

docker-build-api: docker-login
	@echo "Building api image"
	@docker image build -t $(IMAGE_NAME)-api:$(TAG) -f ./api-svc/Dockerfile .
	@docker image push $(IMAGE_NAME)-api:$(TAG)

docker-build-data: docker-login
	@echo "Building rust image"
	@docker image build -t $(IMAGE_NAME)-data:$(TAG) -f ./data-svc/Dockerfile .
	@docker image push $(IMAGE_NAME)-data:$(TAG)

docker-build-frontend: docker-login
	@echo "Building frontend image"
	@docker image build -t $(IMAGE_NAME)-frontend:$(TAG) -f ./frontend-svc/Dockerfile .
	@docker image push $(IMAGE_NAME)-frontend:$(TAG)

clean-docker-config: docker-login docker-build-api docker-build-data docker-build-frontend
	@echo "Cleaning docker config"
	@rm -f /home/runner/.docker/config.json