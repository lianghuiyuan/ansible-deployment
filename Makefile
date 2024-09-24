USE_DOCKER=0
WORK_PATH = $(shell echo $(shell pwd))
CPU_ARCH := $(shell uname -m | sed 's/x86_64/amd64/;s/aarch64/arm64/')

ifeq ($(USE_DOCKER),1)
	PLAYBOOK=docker run --rm -it -v $(WORK_PATH):/work -e ANSIBLE_HOST_KEY_CHECKING=False --network host -w /work registry.jetio.net/library/ansible:2.10-$(CPU_ARCH) ansible-playbook
else
	PLAYBOOK=ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook
endif

.PHONY: pull_images
pull_images:
	@$(PLAYBOOK) -i ./inventory.yaml ./playbooks/kafka.yaml -t pull_images --vault-password-file .vault_pass.txt

.PHONY: load_images
load_images:
	@$(PLAYBOOK) -i ./inventory.yaml ./playbooks/kafka.yaml -t pull_images --vault-password-file .vault_pass.txt

.PHONY: prepare
prepare: pull_images load_images

.PHONY: install
install:
	@$(PLAYBOOK) -i ./inventory.yaml ./playbooks/kafka.yaml -t install --vault-password-file .vault_pass.txt

.PHONY: uninstall
uninstall:
	@$(PLAYBOOK) -i ./inventory.yaml ./playbooks/kafka.yaml -t uninstall --vault-password-file .vault_pass.txt

.PHONY: start
start:
	@$(PLAYBOOK) -i ./inventory.yaml ./playbooks/kafka.yaml -t start --vault-password-file .vault_pass.txt

.PHONY: stop
stop:
	@$(PLAYBOOK) -i ./inventory.yaml ./playbooks/kafka.yaml -t stop --vault-password-file .vault_pass.txt

.PHONY: restart
restart:
	@$(PLAYBOOK) -i ./inventory.yaml ./playbooks/kafka.yaml -t restart --vault-password-file .vault_pass.txt