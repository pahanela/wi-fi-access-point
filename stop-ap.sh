#!/bin/bash

INTERFACE_NAME=wlp1s0

# stop hostapd
sudo killall hostapd

# configure hostapd to default value
sudo ln -sf /etc/hostapd/hostapd-default.conf /etc/hostapd/hostapd.conf

# stop dhcpd
sudo timeout 3s killall --wait dhcpd

# configure dhcpd to default value
sudo ln -sf /etc/dhcp/dhcpd-default.conf /etc/dhcp/dhcpd.conf 

# delete IP address
sudo ip address del 192.168.220.1/24 dev $INTERFACE_NAME

