# Ansible Deployment

## Overview
- deploy kraft kafka cluster

## Requirements

- ansible 2.17.4
  ```
  # ansible --version
    ansible [core 2.17.4]
    config file = /home/lhy/github/ansible-deployment/ansible.cfg
    configured module search path = ['/root/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
    ansible python module location = /usr/local/lib/python3.10/dist-packages/ansible
    ansible collection location = /root/.ansible/collections:/usr/share/ansible/collections
    executable location = /usr/local/bin/ansible
    python version = 3.10.12 (main, Sep 11 2024, 15:47:36) [GCC 11.4.0] (/usr/bin/python3)
    jinja version = 3.0.3
    libyaml = True
  ```
- python 3.0+ (验证: 3.10.12)

## Usage

> 当前通过容器运行 Ansible 因镜像中缺少模块相关模块会报错，请使用宿主机的 Ansible 执行
> macOS 执行pull_kafka_images时需要在 Ansible playbook 或 inventory 文件中设置 Ansible 使用的 Python 解释器路径ansible_python_interpreter，否则会报错提示“Failed to import the required Python library (requests) on docker-desktop's Python /usr/bin/python3” 
> 如果是临时使用： `ansible-playbook -i ./inventory.yaml ./playbooks/kafka.yaml -e "ansible_python_interpreter=/Users/lhy/Documents/jetio/gitlabs/ansible-deployment/.venv/bin/python" -t pull_images`

### 第一步：配置
- ENV： dev-开发环境， test-测试环境， prod-生产环境
- 通过inventories/$(ENV)目录配置服务
  -  `hosts.yaml` 文件是主机列表
  - 配置 `hosts_vars/xxx.yaml` 是针对单个 host 的独立配置，xxx 是主机名
  - 配置 `group_vars/docker_kafka/xxx.yaml` docker_kafka是针对Kafka服务组的公共配置，xxx 名字无限制，可随意命名
  - 配置 `group_vars/all/secrets.yaml` all目录下是针对所有服务的公共配置
- 配置加密的密码文件: `ansible-vault edit group_vars/all/secrets.yaml`
- 将加密的密钥写入`.vault_pass.txt`文件避免输入验证密钥

### 第二步：部署

#### Ansible Playbook
- prepare: `make prepare_kafka`
  - 只拉取镜像: `make pull_kafka_images`
  - 将镜像推送到远程服务器，并加载镜像: `make load_kafka_images`
- install: `make install_kafka`
- start: `make start_kafka`
- stop: `make stop_kafka`
- restart: `make restart_kafka`
- uninstall: `make uninstall_kafka`
- destory: `make destory_kafka`
- update: `make update_kafka`
- recreate: `make recreate_kafka`

## License

MIT