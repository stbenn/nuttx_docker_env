PROJECT_NAME=nuttx_experiment
DOCKER_IMAGE_NAME=nuttx_env/${PROJECT_NAME}
DOCKER_IMAGE_VER=0.1

.PHONY: init
init: build_image
	@echo "Initializing Repositories..."

	git submodule init
	git submodule update

.PHONY: build_image
build_image:
	docker build -t ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_VER} .

.PHONY: launch
launch: build_image
	@echo "Launch...."
	docker run --name=${PROJECT_NAME} --rm -it --privileged -v ${CURDIR}:${CURDIR} ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_VER}