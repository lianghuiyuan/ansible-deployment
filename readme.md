# Ansible Deployment

## Overview

## Requirements

## Installation

## Usage

### ansible-vault
- 通过输入密码将明文文件加密: `ansible-vault encrypt group_vars/all/secrets.yaml`   
- 通过密钥文件将明文文件加密: `ansible-vault encrypt group_vars/all/secrets.yaml --vault-password-file .vault_pass.txt`
- 创建密码文件: `ansible-vault create group_vars/all/secrets.yaml`
- 查看密码文件: `ansible-vault view group_vars/all/secrets.yaml`
- 编辑密码文件: `ansible-vault edit group_vars/all/secrets.yaml`
- 解密文件: `ansible-vault decrypt group_vars/all/secrets.yaml`

### Ansible Playbook
- install: `ansible-playbook -i inventory.yaml ./playbooks/kafka.yaml -t install --vault-password-file .vault_pass.txt`
- start: `ansible-playbook -i inventory.yaml ./playbooks/kafka.yaml -t start --vault-password-file .vault_pass.txt`
- stop: `ansible-playbook -i inventory.yaml ./playbooks/kafka.yaml -t stop --vault-password-file .vault_pass.txt`
- restart: `ansible-playbook -i inventory.yaml ./playbooks/kafka.yaml -t restart --vault-password-file .vault_pass.txt`
- uninstall: `ansible-playbook -i inventory.yaml ./playbooks/kafka.yaml -t uninstall --vault-password-file .vault_pass.txt`
- dry-run: `ansible-playbook -i inventory.yaml ./playbooks/kafka.yaml -t install --check`
- list-tasks: `ansible-playbook -i inventory.yaml ./playbooks/kafka.yaml -t install  --list-tasks`


## License

MIT