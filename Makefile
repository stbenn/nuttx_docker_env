PROJECT_NAME=nuttx_experiment
DOCKER_IMAGE_NAME=nuttx_env/${PROJECT_NAME}
DOCKER_IMAGE_VER=0.1

.PHONY: init
init: build_image
	@echo "Initializing Repositories..."

	@git submodule init
	@git submodule update

.PHONY: build_image
build_image:
	docker build -t ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_VER} .

.PHONY: launch
launch: build_image
	@echo "Launching...."
	@docker run --name=${PROJECT_NAME} --rm -it --privileged \
	-v ${CURDIR}:${CURDIR} \
	--user "$$(id -u):$$(id -g)" \
	${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_VER}

.PHONY: ask_reset
ask_reset:
	@read -p "Reset will remove ALL changes from nuttx and apps repos. Continue? (y/n) " response; \
	if [ "$$response" != "y" ]; then \
		echo "Aborting."; \
		exit 1; \
	fi
	@echo "Continuing..."

.PHONY: reset_repos
reset_repos: ask_reset
	@echo "Resetting nuttx and apps repos to the commits specified by submodules.\n"
	git submodule deinit -f .
	git submodule update --init
	@echo "\nDone resetting repos.\n"