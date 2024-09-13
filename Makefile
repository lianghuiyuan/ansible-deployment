USE_DOCKER=1
JETMON_PATH = $(shell echo $(shell pwd) | sed 's/\/[^\/]*$$//')
CPU_ARCH := $(shell uname -m | sed 's/x86_64/amd64/;s/aarch64/arm64/')

ifeq ($(USE_DOCKER),1)
	PLAYBOOK=docker run --rm -it -v $(JETMON_PATH):/work -e ANSIBLE_HOST_KEY_CHECKING=False --network host -w /work/ansible registry.jetio.net/library/ansible:2.10-$(CPU_ARCH) ansible-playbook
else
	PLAYBOOK=ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook
endif

.PHONY: install-jetmon_server
install-jetmon_server:
	@$(PLAYBOOK) -i ./inventory.yaml ./plays/jetmon_server.yaml -t install
.PHONY: uninstall-jetmon_server
uninstall-jetmon_server:
	@$(PLAYBOOK) -i ./inventory.yaml ./plays/jetmon_server.yaml -t uninstall
.PHONY: start-jetmon_server
start-jetmon_server:
	@$(PLAYBOOK) -i ./inventory.yaml ./plays/jetmon_server.yaml -t start
.PHONY: restart-jetmon_server
restart-jetmon_server:
	@$(PLAYBOOK) -i ./inventory.yaml ./plays/jetmon_server.yaml -t restart

.PHONY: install-exporters
install-exporters:
	@$(PLAYBOOK) -i ./inventory.yaml ./plays/exporters.yaml -t install
.PHONY: uninstall-exporters
uninstall-exporters:
	@$(PLAYBOOK) -i ./inventory.yaml ./plays/exporters.yaml -t uninstall
.PHONY: start-exporters
start-exporters:
	@$(PLAYBOOK) -i ./inventory.yaml ./plays/exporters.yaml -t start
.PHONY: restart-exporters
restart-exporters:
	@$(PLAYBOOK) -i ./inventory.yaml ./plays/exporters.yaml -t restart

.PHONY: install-fluentbit
install-fluentbit:
	@$(PLAYBOOK) -i ./inventory.yaml ./plays/fluentbit.yaml -t install
.PHONY: uninstall-fluentbit
uninstall-fluentbit:
	@$(PLAYBOOK) -i ./inventory.yaml ./plays/fluentbit.yaml -t uninstall
.PHONY: start-fluentbit
start-fluentbit:
	@$(PLAYBOOK) -i ./inventory.yaml ./plays/fluentbit.yaml -t start
.PHONY: restart-fluentbit
restart-fluentbit:
	@$(PLAYBOOK) -i ./inventory.yaml ./plays/fluentbit.yaml -t restart

