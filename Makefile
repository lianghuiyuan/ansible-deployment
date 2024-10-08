USE_DOCKER=0
ENV = dev
WORK_PATH = $(shell echo $(shell pwd))
CPU_ARCH := $(shell uname -m | sed 's/x86_64/amd64/;s/aarch64/arm64/')
PLAYBOOKS = [kibana, elasticsearch]

ifeq ($(USE_DOCKER),1)
	PLAYBOOK=docker run --rm -it -v $(WORK_PATH):/work -e ANSIBLE_HOST_KEY_CHECKING=False --network host -w /work registry.jetio.net/library/ansible:10.4.0-$(CPU_ARCH) ansible-playbook
else
	PLAYBOOK=ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook
endif

.PHONY: pull_kafka_images
pull_kafka_images:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/kafka.yaml -t pull_images

.PHONY: load_kafka_images
load_kafka_images:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/kafka.yaml -t load_images

.PHONY: prepare_kafka
prepare_kafka: load_kafka_images

.PHONY: install_kafka
install_kafka:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/kafka.yaml -t install

.PHONY: uninstall_kafka
uninstall_kafka:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/kafka.yaml -t uninstall

.PHONY: destory_kafka
destory_kafka:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/kafka.yaml -t destory

.PHONY: start_kafka
start_kafka:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/kafka.yaml -t start

.PHONY: stop_kafka
stop_kafka:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/kafka.yaml -t stop

.PHONY: restart_kafka
restart_kafka:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/kafka.yaml -t restart

.PHONY: update_kafka
update_kafka:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/kafka.yaml -t update

.PHONY: recreate_kafka
recreate_kafka:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/kafka.yaml -t recreate


# elasticsearch
.PHONY: pull_es_images
pull_es_images:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/elasticsearch.yaml -t pull_images

.PHONY: load_es_images
load_es_images:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/elasticsearch.yaml -t load_images 

.PHONY: prepare_es
prepare_es: load_es_images

.PHONY: install_es
install_es:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/elasticsearch.yaml -t install -vvvv

.PHONY: uninstall_es
uninstall_es:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/elasticsearch.yaml -t uninstall

.PHONY: destory_es
destory_es:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/elasticsearch.yaml -t destory

.PHONY: start_es
start_es:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/elasticsearch.yaml -t start

.PHONY: stop_es
stop_es:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/elasticsearch.yaml -t stop

.PHONY: restart_es
restart_es:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/elasticsearch.yaml -t restart

.PHONY: update_es
update_es:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/elasticsearch.yaml -t update

.PHONY: recreate_es
recreate_es:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/elasticsearch.yaml -t recreate


# kibana
.PHONY: pull_kibana_images
pull_kibana_images:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/kibana.yaml -t pull_images

.PHONY: load_kibana_images
load_kibana_images:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/kibana.yaml -t load_images

.PHONY: prepare_kibana
prepare_kibana: load_kibana_images

.PHONY: install_kibana
install_kibana:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/kibana.yaml -t install -vvv

.PHONY: uninstall_kibana
uninstall_kibana:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/kibana.yaml -t uninstall

.PHONY: destory_kibana
destory_kibana:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/kibana.yaml -t destory

.PHONY: start_kibana
start_kibana:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/kibana.yaml -t start

.PHONY: stop_kibana
stop_kibana:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/kibana.yaml -t stop

.PHONY: restart_kibana
restart_kibana:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/kibana.yaml -t restart

.PHONY: update_kibana
update_kibana:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/kibana.yaml -t update

.PHONY: recreate_kibana
recreate_kibana:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/kibana.yaml -t recreate


# Redis
.PHONY: pull_redis_images
pull_redis_images:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/redis.yaml -t pull_images

.PHONY: load_redis_images
load_redis_images:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/redis.yaml -t load_images

.PHONY: prepare_redis
prepare_redis: load_redis_images

.PHONY: install_redis
install_redis:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/redis.yaml -t install

.PHONY: uninstall_redis
uninstall_redis:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/redis.yaml -t uninstall

.PHONY: destory_redis
destory_redis:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/redis.yaml -t destory

.PHONY: start_redis
start_redis:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/redis.yaml -t start

.PHONY: stop_redis
stop_redis:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/redis.yaml -t stop

.PHONY: restart_redis
restart_redis:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/redis.yaml -t restart

.PHONY: update_redis
update_redis:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/redis.yaml -t update

.PHONY: recreate_redis
recreate_redis:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/redis.yaml -t recreate


# NATS-Streaming
.PHONY: pull_nats_images
pull_nats_images:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/nats.yaml -t pull_images

.PHONY: load_nats_images
load_nats_images:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/nats.yaml -t load_images

.PHONY: prepare_nats
prepare_nats: load_nats_images

.PHONY: install_nats
install_nats:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/nats.yaml -t install

.PHONY: uninstall_nats
uninstall_nats:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/nats.yaml -t uninstall

.PHONY: destory_nats
destory_nats:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/nats.yaml -t destory

.PHONY: start_nats
start_nats:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/nats.yaml -t start

.PHONY: stop_nats
stop_nats:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/nats.yaml -t stop

.PHONY: restart_nats
restart_nats:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/nats.yaml -t restart

.PHONY: update_nats
update_nats:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/nats.yaml -t update

.PHONY: recreate_nats
recreate_nats:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/nats.yaml -t recreate



# postgreSQL
.PHONY: pull_postgres_images
pull_postgres_images:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/postgres.yaml -t pull_images

.PHONY: load_postgres_images
load_postgres_images:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/postgres.yaml -t load_images

.PHONY: prepare_postgres
prepare_postgres: load_postgres_images

.PHONY: install_postgres
install_postgres:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/postgres.yaml -t install -vvvvvv

.PHONY: uninstall_postgres
uninstall_postgres:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/postgres.yaml -t uninstall

.PHONY: destory_postgres
destory_postgres:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/postgres.yaml -t destory

.PHONY: start_postgres
start_postgres:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/postgres.yaml -t start

.PHONY: stop_postgres
stop_postgres:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/postgres.yaml -t stop

.PHONY: restart_postgres
restart_postgres:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/postgres.yaml -t restart

.PHONY: update_postgres
update_postgres:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/postgres.yaml -t update

.PHONY: recreate_postgres
recreate_postgres:
	@$(PLAYBOOK) -i ./inventories/$(ENV) ./playbooks/postgres.yaml -t recreate