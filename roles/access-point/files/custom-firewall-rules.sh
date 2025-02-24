#!/bin/bash
iptables -I DOCKER-USER -i src_if -o dst_if -j ACCEPT
iptables -t nat -C POSTROUTING -o eth0 -j MASQUERADE || iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables -C FORWARD -i eth0 -o wlan1 -m state --state RELATED,ESTABLISHED -j ACCEPT || iptables -A FORWARD -i eth0 -o wlan1 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -C FORWARD -i wlan1 -o eth0 -j ACCEPT || iptables -A FORWARD -i wlan1 -o eth0 -j ACCEPT

iptables -t nat -C POSTROUTING -o wlan0 -j MASQUERADE || iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE
iptables -C FORWARD -i wlan0 -o wlan1 -m state --state RELATED,ESTABLISHED -j ACCEPT || iptables -A FORWARD -i wlan0 -o wlan1 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -C FORWARD -i wlan1 -o wlan0 -j ACCEPT || iptables -A FORWARD -i wlan1 -o wlan0 -j ACCEPT

iptables-save