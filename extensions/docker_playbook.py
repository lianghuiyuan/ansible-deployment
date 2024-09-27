from collections import namedtuple
from ansible.parsing.dataloader import DataLoader
from ansible.vars import VariableManager
from ansible.inventory import Inventory
from ansible.playbook.play import Play
from ansible.executor.task_queue_manager import TaskQueueManager

# set options for play
Options = namedtuple('Options', ['connection', 'module_path', 'forks',
                                 'become', 'become_method', 'become_user', 'check'])

#initialize needed objects
variable_manager = VariableManager()
loader = DataLoader()
options = Options(connection='local', module_path='', forks=100, become=True,
                  become_method='sudo', become_user='root', check=False)
passwords = dict(vault_pass='secret')

#create inventory and pass to var manager
inventory = Inventory(loader=loader, variable_manager=variable_manager, host_list='localhost')
variable_manager.set_inventory(inventory)

#create play with tasks
play_src = dict(
            name="Install and run a Docker container",
            hosts="localhost",
            gather_facts="no",
            tasks=[
                dict(name="Install Dependencies", action=dict(module="apt", args=dict(name="{{ item }}", update_cache="yes")),
                     with_items=["python-dev", "python-setuptools"]),

                dict(name="Install pip", action=dict(module="easy_install", args=dict(name="pip"))),

                dict(name="Install docker-py", action=dict(module="pip", args=dict(name="docker-py", state="present"))),

                dict(name="Add docker apt-repo", action=dict(module="apt_repository",
                     args=dict(repo="deb https://apt.dockerproject.org/repo ubuntu-trusty main", state="present"))),

                dict(name="Import the Docker repository key", action=dict(module="apt_key",
                     args=dict(url="https://apt.dockerproject.org/gpg", state="present", id="2C52609D"))),

                dict(name="Install Docker package", action=dict(module="apt",
                     args=dict(name="docker-engine", update_cache="yes"))),

               dict(name="Create a data container", action=dict(module="docker_container",
                                                         args=dict(name="test", image="busybox", volumes="/data"))),

               dict(name="Run a command", action=dict(module="command", args="docker run busybox /bin/echo 'hello world'"),
                    register="output"),

               dict(name="Output", action=dict(module="debug", args=dict(var="output.stdout_lines"))),
             ],
            handlers=[dict(name="restart docker",
                           action=dict(module="service", args=dict(name="docker", state="restarted")))]
        )
play = Play().load(play_src, variable_manager=variable_manager, loader=loader)

#actually run it
tqm = None
try:
    tqm = TaskQueueManager(
            inventory=inventory,
            variable_manager=variable_manager,
            loader=loader,
            options=options,
            passwords=passwords,
            stdout_callback="default",
        )
    result = tqm.run(play)
finally:
    if tqm is not None:
        tqm.cleanup()