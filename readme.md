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

### 第一步：配置

- 配置 `inventory.yaml` 文件
- 配置 `hosts_vars/xxx.yaml` 文件
- 配置 `group_vars/docker_kafka/xxx.yaml` 文件
- 配置加密的密码文件: `ansible-vault edit group_vars/all/secrets.yaml`
- 将加密的密钥写入`.vault_pass.txt`文件避免输入验证密钥

### 第二步：部署

#### ansible-vault
- 通过输入密码将明文文件加密: `ansible-vault encrypt group_vars/all/secrets.yaml`   
- 通过密钥文件将明文文件加密: `ansible-vault encrypt group_vars/all/secrets.yaml --vault-password-file .vault_pass.txt`
- 创建密码文件: `ansible-vault create group_vars/all/secrets.yaml`
- 查看密码文件: `ansible-vault view group_vars/all/secrets.yaml`
- 编辑密码文件: `ansible-vault edit group_vars/all/secrets.yaml`
- 解密文件: `ansible-vault decrypt group_vars/all/secrets.yaml`

#### Ansible Playbook
- prepare: `make prepare`
  - 只拉取镜像: `make pull_images`
  - 将镜像推送到远程服务器，并加载镜像: `make load_images`
- install: `make install`
- start: `make start`
- stop: `make stop`
- restart: `make restart`
- uninstall: `make uninstall`

## License

MIT