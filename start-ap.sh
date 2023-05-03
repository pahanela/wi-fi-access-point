#!/bin/bash

INTERFACE_NAME=wlp1s0

#
sudo ip address flush $INTERFACE_NAME

# assign static IP to the interface
sudo ip address add 192.168.220.1/24 dev $INTERFACE_NAME

# configure hostapd
sudo ln -sf /etc/hostapd/hostapd-5ghz.conf /etc/hostapd/hostapd.conf

# configure dhcpd
sudo ln -sf /etc/dhcp/dhcpd-192.168.220.0.conf /etc/dhcp/dhcpd.conf

# allow to modify DHCP leases file
sudo chmod a+w /var/lib/dhcp/dhcpd.leases

# start dhcpd service
sudo dhcpd -cf /etc/dhcp/dhcpd.conf $INTERFACE_NAME

# start hostapd service
sudo hostapd /etc/hostapd/hostapd.conf -i $INTERFACE_NAME

# enable IP forwarding
#echo 1 > /proc/sys/net/ipv4/ip_forward 
echo 1 | sudo tee /proc/sys/net/ipv4/ip_forward

# setup IP masquerading
sudo iptables -t nat -A POSTROUTING -s 192.168.220.0/24 -o eth0 -j MASQUERADE

