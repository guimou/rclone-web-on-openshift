.PHONY: default all build validate

RELEASE ?= $(shell git describe --tags --always --dirty || echo 'dev')
REQUIRED_RUNTIME_IMAGE_COMMANDS ?= "rclone"

default:
	@echo "Rclone for OpenShift standalone image builder"
	@echo "Options are:"
	@echo "all : builds and validates the image"
	@echo "build : builds the image".
	@echo "validate : validates the image"
	@echo "---"
	@echo "Please specify:"
	@echo " - the release number with RELEASE=... (defaults to 'dev' or git tag)"

all: build validate

build:
	cd container && podman build -t rclone-web-openshift:odh-rhods_${RELEASE} .

validate:
	@required_commands=$(REQUIRED_RUNTIME_IMAGE_COMMANDS) ; \
	IMAGE=rclone-web-openshift:standalone_$(RELEASE) ; \
	if [[ $$IMAGE == "" ]] ; then \
		echo "Usage: make validate IMAGE=<container-image-name>" ; \
		exit 1 ; \
	fi ; \
	fail=0; \
	echo "-----------------------------------------------------------" ; \
	echo "Validating container image $$IMAGE" ; \
	echo "-----------------------------------------------------------" ; \
	echo "=> Loading container image ..." ; \
	podman inspect $$IMAGE > /dev/null 2>&1 ; \
	if [ $$? -ne 0 ]; then \
		echo "Container image $$IMAGE is not present or failing" ; \
		exit 1; \
	fi; \
	for cmd in $$required_commands ; do \
		echo "=> Checking container image $$IMAGE for $$cmd..." ; \
		podman run --rm  --entrypoint /bin/bash $$IMAGE -c "which $$cmd  > /dev/null 2>&1 " ; \
		if [ $$? -ne 0 ]; then \
			echo "ERROR: Container image $$IMAGE does not meet criteria for command: $$cmd" ; \
			fail=1; \
			continue; \
		fi; \
	done ; \
	echo "=> Checking for Rclone ability to start..." ; \
	podman run -d --network=host --name validation-container $$IMAGE ; \
	for i in {1..6}; do \
		nc -z localhost 5572 && break || sleep 5; \
	done; \
	nc -z localhost 5572 ; \
	if [ $$? -ne 0 ]; then \
		echo "ERROR: Image $$IMAGE cannot start Rclone" ; \
		fail=1; \
	fi; \
	echo "Removing container" ; \
	podman stop validation-container && podman rm validation-container ; \
	echo "-----------------------------------------------------------" ; \
	if [ $$fail -eq 1 ]; then \
		echo "=> ERROR: Container image $$IMAGE failed to validate" ; \
		exit 1 ; \
	else \
		echo "=> Container image $$IMAGE validated" ; \
	fi; \