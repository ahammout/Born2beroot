# INTRODUCTION

This project aims to introduce you to the wonderful world of virtualization.
You will create your first machine in VirtualBox (or UTM if you can’t use VirtualBox)
under specific instructions. Then, at the end of this project, you will be able to set up
your own operating system while implementing strict rules.

# DEFINITIONS

- your choice of operating system ? 
  
  - The operating system that i chosed is Debian, The cause of my choise is that debian is easy for work and is popular, the centOS is a commercial operating system (and i did not tried it before) and is not popular like Debian.

- What is a virtual machine ? 
  
  + a virtual machine is virtual computer who have a virtual hardware comes from the host (physical server), a virtual machine it's a complet computer who have an operating system and a virtual ram,cpu,disk,network adapter, every piece from the hardware have a virtual side that the virtual machine can use it .

- How a virtual machine works ?
  
  - So the virtual machine shares the hardware with the host (physical server) we can say that the virtual mahcine it's a server ! but how this heppens, the hypervisor is a software who gaves the virtual machine a virtual hardware, every piece of hardware have a virtual side, the hypervisor is the manager who can do this job . 

- The basic deffrences between CentOS and Debian ?
  
  + The basic defference between CentOS and Debian  is that CentOS from a commercial RedHat Entreprise, and is a free operating system like Debian;  Debain is a free software too like CentOS and open source, The main diffrent is that Debian  is too popular and have an easy interface for the user, and he is the upstream for other distributions which are famos too like Ubentu linux distribution.

- What is the purpose of vitual machine ? 
  
  + The purpose of the virtual machine is to use diffrent operating systems in a single host without changing the oreginal host operating system, also to try diffrent application, for example trying apps and tools that works just in linux distributions even if the host have windows OS.

- What is the difference between Apt and aptitude?
  
  - Firstly Apt and Aptitude  haves the same job which is managing  installing and removing packeges, the main different is that aptitude is advance from apt, aptitude uses a terminal menu interface   in contrast apt can't do this, the default package manager for debian is dpkg who can install and remove, display packages with a list of dependecies, apt uses dpkg software, However apt can handle and fetch for the necessary dependencies when installing a program, for example when updating the system apt looks for the available new dependencies of new softwares, aptitude is an advance and a complet package manager, aptitude can give a menu terminl interface to chose the needed software.
  
  - so the main different is that aptitude is a high-level packege manager while Apt is lower-level packege manager. also apt-get support a GUI but aptitude works by text only. 
+ What is APPArmor ? 
  
  - APPARmor is a software of security who responsible about controlling apps to do thier jobs only, for example if some software can take photos by accessing the camera application, but the administrator denies this privilege, the application will not be able to access the camera application, processes are restricted by profiles. Profiles can work in complain-mode and in enforce-mode. in enforce-mode, AppArmor prohibits applications from performing restricted tasks. In complain-mode, AppArmor allows applications to do these tasks, but creates a registry to display the complaint.
    
    + To display APPArmor status use the command : 
      
      + $sudo aa-status$
  
  # Simple setup
  
  ###### 1. Password age :
  
  - $sudo vim /etc/login.difs
    
    + line 160 : PASS_MAX_DAYS    : Maximum number of days a password may be used.  ===> Change it to :  **30**
    
    + Line 161 : PASS_MIN_DAYS : Mninmum number of days allowed between password changes ===> change irt to : **2**
    
    + Line 162 : PASS_WARN_AGE :  Number of days warning given before a password expires.  ===> change it to : **7**
  
  ###### 2. Password Strengh:
  
  + $ sudo vim /etc/pam.d/common-password
  
  + minlen=10 : password minimum lengh is 10 .
  
  + retry=3 : retry password 3 times.
  
  + dcredit=-1 : password countain 1 digit at least. 
  
  + ucredit=-1 : password countain 1 uppercase at least .
  
  + lcredit=-1 : password  countain 1 lowercase at least .
  
  + maxrepeat=3 : max of repeating the same character is lese than 3; (~~SSSS~~).
  
  + checkusers=0 : the password most not countain the name of the user .
  
  + difok=7 : The new password most have 7 different characters with the old password .
  
  + enforce_for_root : implement the same policy on root .
  
  ###### 3. Checking the ufw service is started .
  
  + $ sudo service ufw status .
  
  + $sudo ufw status.
  
  ###### 4. Checking the SSH service is started.
  
  + $ sudo service ssh status. 
  
  ###### 5. check that the Operating system is debian or CentOS .
  
  + head -n 2 /etc/os-release.
  
  ###### 6. Check that a user with your login is present on the VM
  
  + All the users of the VM are inside a file named by passwd 
    
    + you can access to the file and look for the user in /etc/passwd
    
    + Or use this command :
      
      + $ sudo cat /etc/passwd | grep "your user name"
  
  # Hostname and partitions:
  
  ###### 1. checking the hostname and changing it .
  
  + To check the current hostname use the command  : $ Hostname
  
  + To change the current hostname see /etc/Hostname
    
    + remove the original hostname and change it by the new one.
    
    + restart the machine.
  
  ###### 2. Show the partitions of the virtual machine
  
  + $ lsblk
  
  + Compare the output of the command with the example given in the subject.
  
  ###### 3. Explain how LVM works and what it is about.
  
  + creating single logical volumes off multiple pysical volumes or entire hard disk, allowing for dynamic resizing.
  
  + managing large hard disk farms by allowing disks to be addesd and replaced without downtime or service distruption.
  
  + On small system (like disktop), instead of having to estimate at installation time how big a partition might need to be, LVM allows filesystems to be asily resized as needed.
  
  + LVM (Logical Volume Manager) is an abstraction layer between a storage device and a file system. We get many advantages from using LVM, but the main advantage is that we have much more flexibility when it comes to managing partitions. Suppose we create four partitions on our storage disk. If for any reason we need to expand the storage of the first three partitions, we will not be able to because there is no space available next to them. In case we want to extend the last partition, we will always have the limit imposed by the disk. In other words, we will not be able to manipulate partitions in a friendly way. Thanks to LVM, all these problems are solved. By using LVM, we can expand the storage of any partition (now known as a logical volume) whenever we want without worrying about the contiguous space available on each logical volume. We can do this with available storage located on different physical disks (which we cannot do with traditional partitions). We can also move different logical volumes between physical devices. Of course, services and processes will work the same way they always have. But to understand all this, we have to know:
    
    + Physical Volume (PV): physical storage device. It can be a hard disk, an SD card, a floppy disk, etc. This device provides us with storage available to use
    
    + Volume Group (VG): to use the space provided by a PV, it must be allocated in a volume group. It is like a virtual storage disk that will be used by logical volumes. VGs can grow over time by adding new VPs.
    
    + Logical volume (LV): these devices will be the ones we will use to create file systems, swaps, virtual machines, etc. If the VG is the storage disk, the LV are the partitions that are made on this disk.
  
  # SUDO
  
  ###### 1. Check That the sudo program is properly installed on the virtual machine.
  
  + $ dpkg -l sudo 
  
  ###### 2. Show  your new user on the "sudo" group
  
  + $ getent group sudo
  
  ###### 3. The subject imposes strict rules for sudo. Explain the value and operations of sudo.
  
  + setting the limit to 3 attempts in the event of an incorrect password to prevent protefursing.
  
  + We archieve each action of sudo to keep track of the commands executed using sudo.
  
  + The TTY mode has to be enable to restrict the apps from running commands executed in background processes,
  
  + secure path it's used for every command run with sudo, it has two importances
    
    + 1. Used when a system administrator deos not trust sudo users to have a secure PATH envirement variable
      
      2. To separate "root path" and "users path", only users defined by exempt_group are not affected by this setting.
  
  ###### 4. Show the implementationof the rules imposed by the subject.
  
  + passwd_tries.
  
  + badpass_message.
  
  + logfile.
  
  + log_input, log_output.
  
  + TTY.
  
  + secure_path.
  
  ###### 5. Verify that the "var/log/sudo" folder exist and have at least on file
  
  ###### 6. Check the contents of the files in this folder (You should see a history of the command used with sudo ).
  
  ###### 7. Run a command via sudo and check the file in "/var/log/sudo" folder have been updated.
  
  # UFW
  
  ###### 1.ِ Check that the "UFW" program is properly installed on the VM
  
  + $ dpkg -l | grep ufw
  
  ###### 2. Check that it is working properly.
  
  + $ sudo service ufw status 
  
  ###### 3. Explain what is ufw and the value of using it.
  
  + UFW (Uncomplicated firewall) is a software application responsible for ensuring that the system administrator can menage iptables in a simple way. Since it is very difficult to work with iptables, ufw provides us with an interface to modify the firewall of our device (netfilter) without compromising security. once we have UFW installed, we can chose which ports we want to allow connections, and which ports we want to close. This will also be very useful with SSH, greatly improving all security related to comminacations between devices.
  
  ###### 4. List the active rules in UFW. A rule must exist for port 4242
  
  + $ sudo ufw status 
  
  ###### 5. add a new rules to open port 8080. Check that this on
  
  + $ sudo ufw allow 8080
  
  ###### 6. Delete the new rule
  
  + $ sudo ufw delete allow 8080
  
  # SSH
  
  ###### 1. Check that the ssh is installed on the virtual machine.
  
  + $ dpkg -l ssh 
  
  ###### 2. Check that is working properly.
  
  + $ sudo service ssh status 
  
  ###### 3.   What basically what SSH is and the value of using it.
  
  + SSH is short of secure shell is a protocol to make the connection with other device secure and he is resposible about making that connection possible provides a mechanism to authenticate a user remotely, transfer data from the client to the host, and return a response to the request made by the client.
  
  + SSH was created as an alternative to telnet, which does not encrypt the information that is sent. SSH uses encryption techniques to ensure that all client-to-host and host-to-client communications are don in encrypted form. one of the advantages of SSH is that a user using linux or MacOS can use SSH on their server to communicate with it remotely through thier computer's terminal. Once authenticated, that user will be able to use the terminal to work on the server.
  
  + There are three diffrent techniques that SSH uses to encrypt : 
    
    + Symmetric encryption : 
    
    + Asymmetric encryption :
    
    + Hasshing :
  
  ###### 4. Verify that the SSH service only uses port 4242.
  
  + Check the sshd_config file in /etc/ssh/sshd_config
  
  ###### 5. log in with the newly created user using SSH.
  
  ###### 6. Make sure that you cannot use ssh with the "root" user .
  
  # Script monitoring
  
  ###### 1. Explain how the script work by showing the code.
  
  ###### 2. What cron is.
  
  + Cron is a linux task manager that allows us to execute commands at a certain time. We can automate some tasks just by telling cron what command we want  to run at a specific time. For example, if we want to restart our server every day at 4:00 am, instead of having to wake up at that time, cron will do it for you.
  
  + The crontab command line utility, also known as cron job scheduler on unix-like operating systems.
  
  + * * * * * path/to/script.sh
  
  + each of the fields has the following meaning.
    
    + [Minute] [hour] [Day_of_the_month] [month_of_the_year] [Day_of_the_week] [ Command ]
      
      + Minute 0 - 59
      
      + Hour 0 - 23
      
      + Day of the month 1 - 31
      
      + month of the year 1 - 12
      
      + Day of the week 0 - 7
  
  ###### 3. Explain how you set up the script so that it runs every 10 minutes from when the server starts.
  
  ###### 4. Ensure that this script runs every minute.
  
  ###### 5. Make the script stop running when the server has started up (without modifying the script itself).
