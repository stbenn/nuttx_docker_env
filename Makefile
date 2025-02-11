PROJECT_NAME=nuttx_experiment
DOCKER_IMAGE_NAME=nuttx_env/${PROJECT_NAME}
DOCKER_IMAGE_VER=0.2

.PHONY: init
init: build_image
	@git submodule init
	@git submodule update

	@$(MAKE) link_apps

	@chmod +x nucleo_g071_nsh_config.sh

	@echo "\nProject repo initialization done!\n"

.PHONY: link_apps
link_apps:
	@echo "Linking app directories into nuttx apps/external."
	@mkdir -p apps/external
	@cp Make.defs.t apps/external/Make.defs
	@cp Makefile.t apps/external/Makefile
	@rm -rf apps/external/ExternalHello
	@ln -sr ExternalHello apps/external/ExternalHello
	@echo "Done with app link."

.PHONY: build_image
build_image:
	docker build -t ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_VER} .

# Add the user to dialout and plugdev for usb access. sudo so it's possible to do root commands
.PHONY: launch
launch: build_image
	@echo "Launching...."
	@docker run --name=${PROJECT_NAME} --rm -it --privileged \
	--user "$$(id -u):$$(id -g)" --group-add dialout --group-add sudo --group-add plugdev \
	-v ${CURDIR}:${CURDIR} \
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
	rm -rf apps/external 
	git submodule deinit -f .
	git submodule update --init
	@echo "\nDone resetting repos.\n"
