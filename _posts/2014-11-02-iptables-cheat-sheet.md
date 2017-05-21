---
layout: post
title: "Iptables cheat sheet"
excerpt:
date: 2014-11-02T16:28:55-04:00
modified: 2017-05-21T23:17:49-04:00
categories: blog
tags: ["iptables", "linux"]
---

# Backup/Restore

```bash
# Save
iptables-save > fichier_de_backup

# Restore
iptables-restore < fichier_de_backup
```

# List rules

```bash
# Forwarding rules
iptables -t nat -L -n -v

# All rules
iptables -L -n -v
```

# Create rules

```bash
# Redirect all TCP traffict from port 25 to port 2525
iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 25 -j REDIRECT --to-port 2525

# Allow internet connection when you are connected through a VPN
iptables -t nat -A POSTROUTING -s 192.168.0/24 -o eth0 -j MASQUERADE
```

# Delete all rules

```bash
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X
iptables -t mangle -F
iptables -t mangle -X
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT
```

One could use `netfilter-persistent` to persist iptables rules :

```bash
netfilter-persistent flush
```

# List opened ports

```bash
# https://explainshell.com/explain?cmd=netstat+--inet+-nplae
# --inet only displa type net connection (udp/tcp, etc.)
netstat --inet -nplae
```

# References

- [Debian's iptables](https://wiki.debian.org/iptables)
