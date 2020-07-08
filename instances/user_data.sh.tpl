#!/bin/bash

# Activate and set port forwarding
sysctl -w net.ipv4.ip_forward=1
echo 'net.ipv4.ip_forward = 1' >> /etc/sysctl.d/99-nat.conf

# Update system packages and install required packages
yum update -y
yum install iptables-services -y

# Set iptables rules for allowing traffic in port 433
iptables -t nat -A POSTROUTING -o eth0 -s ${private_subnet_cidr} -j MASQUERADE
iptables -A FORWARD -p tcp --dport 443 -s ${private_subnet_cidr} -j ACCEPT
iptables -A FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -j DROP
# Save iptables configuration
iptables-save > /etc/sysconfig/iptables
systemctl enable iptables.service