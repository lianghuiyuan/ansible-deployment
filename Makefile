USE_DOCKER=0
WORK_PATH = $(shell echo $(shell pwd))
CPU_ARCH := $(shell uname -m | sed 's/x86_64/amd64/;s/aarch64/arm64/')

ifeq ($(USE_DOCKER),1)
	PLAYBOOK=docker run --rm -it -v $(WORK_PATH):/work -e ANSIBLE_HOST_KEY_CHECKING=False --network host -w /work registry.jetio.net/library/ansible:2.10-$(CPU_ARCH) ansible-playbook
else
	PLAYBOOK=ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook
endif

.PHONY: pull_kafka_images
pull_kafka_images:
	@$(PLAYBOOK) -i ./inventory.yaml ./playbooks/kafka.yaml -t pull_images --vault-password-file .vault_pass.txt

.PHONY: load_kafka_images
load_kafka_images:
	@$(PLAYBOOK) -i ./inventory.yaml ./playbooks/kafka.yaml -t pull_images --vault-password-file .vault_pass.txt

.PHONY: prepare_kafka
prepare_kafka: pull_kafka_images load_kafka_images

.PHONY: install_kafka
install_kafka:
	@$(PLAYBOOK) -i ./inventory.yaml ./playbooks/kafka.yaml -t install --vault-password-file .vault_pass.txt

.PHONY: uninstall_kafka
uninstall_kafka:
	@$(PLAYBOOK) -i ./inventory.yaml ./playbooks/kafka.yaml -t uninstall --vault-password-file .vault_pass.txt

.PHONY: start_kafka
start_kafka:
	@$(PLAYBOOK) -i ./inventory.yaml ./playbooks/kafka.yaml -t start --vault-password-file .vault_pass.txt

.PHONY: stop_kafka
stop_kafka:
	@$(PLAYBOOK) -i ./inventory.yaml ./playbooks/kafka.yaml -t stop --vault-password-file .vault_pass.txt

.PHONY: restart_kafka
restart_kafka:
	@$(PLAYBOOK) -i ./inventory.yaml ./playbooks/kafka.yaml -t restart --vault-password-file .vault_pass.txt