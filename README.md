# Week-13-Homework
Week 13 HW (GitHub Fundamentals) and ELK-Stack-Project

The rest of the submission for the ELK-Stack-Project is in the Ansible directory (/Ansible/README)

## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![TODO: README/Images/ELK Project Network Diagram.png]

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the __playbook___ file may be used to install only certain pieces of it, such as Filebeat.

  - _TODO: elk-playbook.yml
---
- name: Configure Elk VM with Docker
  hosts: elkservers
  become: true
  tasks:
#install services      
  - name: Install docker.io
    apt:
      force_apt_get: yes
      name: docker.io
      state: present

  - name: Install python-pip
    apt:
      force_apt_get: yes
      name: python-pip
      state: present

  - name: Install Docker python module
    pip:
      name: docker
      state: present

#increase virtual memory
  - name: Increase virtual memory
    command: sysctl -w vm.max_map_count=262144
  - name: download and launch a docker elk container
    docker_container:
      name: elk
      image: sebp/elk
      state: started
    # Please list the ports that ELK runs on
      published_ports:
        - 5601:5601
        - 9200:9200
        - 5044:5044


This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly __available___, in addition to restricting _access____ to the network.
- _TODO: What aspect of security do load balancers protect? What is the advantage of a jump box?_
Of the CIA triad, load balancers protect availability of the website. A load balancer first gives the public IP address for internet to access. 
Then it receives the traffic that goes into the website, and distributes the load across several servers, such that a DoS, denial of service attack 
can be prevented.
The advantage of the jump box is that it helps secure the virtual network and the VMs. The jump box machine will be placed in between the internet 
and the other machines. It will act as a control, and allowing only IP addresses allowed  by the jump box to go to the other machines, 
which makes it easier to secure the network.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the _information____ and system _logs____.
- _TODO: What does Filebeat watch for?_
Filebeat watches for log information about the file system (log files), such as Apache and Microsoft Azure.
- _TODO: What does Metricbeat record?_
Metricbeat collects information about machine metrics, such as the uptime.

The configuration details of each machine may be found below.
_Note: Use the [Markdown Table Generator](http://www.tablesgenerator.com/markdown_tables) to add/remove values from the table_.

| Name     | Function | IP Address | Operating System |
|----------|----------|------------|------------------|
| Jump Box | Gateway  | 10.0.0.5   | Linux (ubuntu 18.04)  |
| DVWA-VM1  |  Machine/Docker | 10.0.0.6      | Linux (ubuntu 18.04) |
| ELK  |  ELK stack server |  10.0.0.4 |  Linux (ubuntu 18.04)  |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the _ELK____ machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
- _TODO: Add whitelisted IP addresses_
My public IP address; 100.19.60.213
Machines within the network can only be accessed by _jumpbox____.
- _TODO: Which machine did you allow to access your ELK VM? What was its IP address?_
Only the Jumpbox machine has access to my ELK VM. The IP address for the Jumpbox was 10.0.0.5, while for the ELK, it was 10.0.0.4.
A summary of the access policies in place can be found in the table below.

| Name     | Publicly Accessible | Allowed IP Addresses |
|----------|---------------------|----------------------|
| Jump Box | Yes     | 100.19.60.213  10.0.0.4  10.0.0.6 |
| DVWA-VM1         |    No  |   10.0.0.5    |
|  ELK        |   Yes    |    10.0.0.5   |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because...
- _TODO: What is the main advantage of automating configuration with Ansible?_
To automate configuration, all you need to do is input tasks into the playbooks, such that it is simple and less messy.
The playbook implements the following tasks:
- _TODO: In 3-5 bullets, explain the steps of the ELK installation play. E.g., install Docker; download image; etc._
- Run a command to use more memory
- Install 3 packages: Docker engine, python software, and python client for docker
- Downloads docker container image sebp/elk
- Configures 3 ports for ELK to run on: 5601:5601 9200:9200 5044:5044

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

![TODO: README/Images/docker_ps_output.png]

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- _TODO: List the IP addresses of the machines you are monitoring_
10.0.0.6
We have installed the following Beats on these machines:
- _TODO: Specify which Beats you successfully installed_
Filebeat
These Beats allow us to collect the following information from each machine:
- _TODO: In 1-2 sentences, explain what kind of data each beat collects, and provide 1 example of what you expect to see. E.g., `Winlogbeat` collects Windows logs, which we use to track user logon events, etc._
Filebeat collects log files, so when there are network issues, it will remember where it left off before the interruption.

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the _filebeat-configuration.yml____ file to _filebeat.yml____.
- Update the __filebeat-configuration.yml___ file to include...information from ELK machine.
- Run the playbook, and navigate to _the Filebeat installation page___ to check that the installation worked as expected.

_TODO: Answer the following questions to fill in the blanks:_
- _Which file is the playbook? Where do you copy it?_
"filebeat-configuration.yml" is the playbook. In filebeat-playbook.yml, you copy it to the ELK VM, via filebeat.yml.
- _Which file do you update to make Ansible run the playbook on a specific machine? How do I specify which machine to install the ELK server on versus which to install Filebeat on?_
To make Ansible run on a specific machine, you edit the /etc/ansible/hosts file.  Under the file, you can make specific groups which caters to each playbook, such as the ELK server playbook and Filebeat playbook. For this case, the [webservers] group catered to the Filebeat playbook, while the [elkservers] group was listed for the ELK server.  In each playbook, you would list the group name next to "hosts:".
- _Which URL do you navigate to in order to check that the ELK server is running?
You can verify that the ELK server is running by navigating to "http://[my.VM.IP]:5601", in my cae, " http://100.19.60.213:5601" to check that the ELK server is running. It will go to a kibana website

Screenshot for website: /README/Images/Kibana.png
Screenshot for filebeat: /README/Images/Filebeat.png
    
    _As a **Bonus**, provide the specific commands the user will need to run to download the playbook, update the files, etc._
    ansible-playbook playbook.yml
    
