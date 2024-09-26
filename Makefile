USE_DOCKER=1
WORK_PATH = $(shell echo $(shell pwd))
CPU_ARCH := $(shell uname -m | sed 's/x86_64/amd64/;s/aarch64/arm64/')

ifeq ($(USE_DOCKER),1)
	PLAYBOOK=docker run --rm -it -v $(WORK_PATH):/work -e ANSIBLE_HOST_KEY_CHECKING=False --network host -w /work registry.jetio.net/library/ansible:10.4.0-$(CPU_ARCH) ansible-playbook
else
	PLAYBOOK=ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook
endif

.PHONY: pull_kafka_images
pull_kafka_images:
	@$(PLAYBOOK) -i ./inventory.yaml ./playbooks/kafka.yaml -t pull_images

.PHONY: load_kafka_images
load_kafka_images:
	@$(PLAYBOOK) -i ./inventory.yaml ./playbooks/kafka.yaml -t pull_images

.PHONY: prepare_kafka
prepare_kafka: load_kafka_images

.PHONY: install_kafka
install_kafka:
	@$(PLAYBOOK) -i ./inventory.yaml ./playbooks/kafka.yaml -t install

.PHONY: uninstall_kafka
uninstall_kafka:
	@$(PLAYBOOK) -i ./inventory.yaml ./playbooks/kafka.yaml -t uninstall

.PHONY: destory_kafka
destory_kafka:
	@$(PLAYBOOK) -i ./inventory.yaml ./playbooks/kafka.yaml -t uninstall

.PHONY: start_kafka
start_kafka:
	@$(PLAYBOOK) -i ./inventory.yaml ./playbooks/kafka.yaml -t start

.PHONY: stop_kafka
stop_kafka:
	@$(PLAYBOOK) -i ./inventory.yaml ./playbooks/kafka.yaml -t stop

.PHONY: restart_kafka
restart_kafka:
	@$(PLAYBOOK) -i ./inventory.yaml ./playbooks/kafka.yaml -t restart