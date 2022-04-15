#!/bin/bash

# architecture of operating system
arc=$(uname -a)

# number of physical processor
CPU=$(grep 'physical id' /proc/cpuinfo | wc -l)

# number of virtual processor
vCPU=$(grep 'processor' /proc/cpuinfo | wc -l)

# current available RAM on the server, and its utilization rate as a percentage
RAM_Usage=$(free -m | awk 'NR == 2 {printf("%d/%dMB (%.2f%%)"), $3, $2, $3/$2*100}')

# current available memory on the server, and its utilization rate as a percentage
U_Disk=$(df -Bm | grep '^/dev/' | grep -v '/boot' | awk '{US += $3} END {print US}')
T_Disk=$(df -Bg | grep '^/dev/' | grep -v '/boot' | awk '{TD += $2} END {print TD}')
Usage_P=$(df -Bm | grep '^/dev/' | grep -v '/boot' | awk '{US += $3} END {TD += $2} END {printf("%.2f"), US/TD*100}')

# current utilization rate of the processor as a percentage
P_CPU=$(top -bn1 | grep '^%Cpu' | awk '{printf("%.1f%%"), $2 + $4}')

# date and time of the last reboot
L_Boot=$(who -b | awk '$1 == "system" {printf("%s %s"), $3, $4}')

# LVM status
Lvm_s=$(lsblk | grep 'lvm' | wc -l)
Lvm_status=$(if [ $lvm_s -eq 0 ]; then echo no; else echo yes; fi)

# number of active connection
TCP_connex=$(netstat -an | grep "ESTABLISHED" | wc -l)


# number of users using the server
Users=$(who | cut -d " " -f 1 | sort -u | wc -l)
# IPv4 of the server, and MAC address
IPv4=$(hostname -I)
MAC=$(ip a | grep "link/ether" | awk '{print $2}')

# the number of commands executed with the sudo program


wall"
	#Architecture: $arc
	#CPU physical : $CPU
	#vCPU :$vCPU
	#Memory Usage : $RAM_Usage
	#Disk Usage : $U_Disk/$T_Disk ($Usage_P)
	#CPU load: $P_CPU
	#Last boot: $L_Boot
	#LVM use : $Lvm_status
	#Connexions TCP : $TCP_connex ESTABLISHED
	#User log: $Users
	#Neptwork: IP $IPv4 ($MAC)"