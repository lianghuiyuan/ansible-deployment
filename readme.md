# Ansible Deployment

## Overview

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