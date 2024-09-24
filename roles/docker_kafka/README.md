Role Name
=========

deploy kraft kafka cluster on docker

Requirements
------------

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

Role Variables
--------------

- group_vars/all/vars.yaml
  ```
  service_ip: '{{ host_inner_address }}'
  cpu_arch: "{{ (ansible_architecture | lower | 
                replace('i386', '386') | 
                replace('x86_64', 'amd64') | 
                replace('aarch64', 'arm64') | 
                replace('armv7l', 'armv7') | 
                replace('armv6l', 'armv6')) if ansible_architecture is defined else '' }}"
  image_archive_dir: '/tmp/images'
  ```
- group_vars/docker_kafka/vars.yaml
  ```
  ---
  version: "{{ '3.8.0_' + (cpu_arch | lower) }}"
  image: 'registry.jetio.net/library/apache/kafka'
  image_archive_name: 'kafka_{{ version }}.tar'

  # vip: '10.162.100.127'
  # kafka_cluster_id: 'jetio_kafka_cluster'
  kafka_cluster_id: '4L6g3nShT-eMCtK--X86sw'
  topics:
    - name: 'bucket-log'         # for logmanager
      partitions: 3
      replication_factor: 1

  kafka_shell_dir: /opt/kafka/bin
  kafka_config_dir: /opt/kafka/config
  kafka_log_dir: /var/log/kafka
  kafka_data_dir: /mnt/kafka

  container_shell_dir: /opt/kafka/bin
  container_config_dir: /opt/kafka/config
  container_log_dir: /tmp/kraft-combined-logs
  container_data_dir: /var/lib/kafka
  ```
- host_vars
  ```
  ---
  host_outer_address: '47.99.102.51'
  host_inner_address: '192.168.10.203'

  kafka_broker_id: 1
  kafka_host_broker_port: 9092
  kafka_host_controller_port: 9093
  ```

Dependencies
------------

A list of other roles hosted on Galaxy should go here, plus any details in regards to parameters that may need to be set for other roles, or variables that are used from other roles.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

- name: 'deploy kafka'
  hosts: 'docker_kafka'
  become: true
  become_method: sudo
  become_user: root
  gather_facts: true
  roles:
    - { role: 'docker_kafka'}

License
-------

BSD

Author Information
------------------

lhy.me
