---
layout: post
title: "Mémo iptables"
excerpt:
date: 2014-11-02T16:28:55-04:00
modified: 2016-11-12T23:17:55-04:00
categories: blog
tags: ["iptables","admin sys", "linux"]
---

# Backup/Restore

```bash
# Sauvegarde
iptables-save > fichier_de_backup
# Restauration
iptables-restore < fichier_de_backup
```

# Consultation des règles

```bash
# Règles forwarding
iptables -t nat -L -n -v

# Toutes les règles
iptables -L -n -v
```

# Création de règles

```bash
# Redirige tout le traffic TCP entrant sur le port 25, vers le port 2525
iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 25 -j REDIRECT --to-port 2525
# Permet l’accès à internet aux personnes connectées sur le VPN
iptables -t nat -A POSTROUTING -s 192.168.0/24 -o eth0 -j MASQUERADE
```

# Purger toutes les règles

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

Il est aussi possible d'utiliser `netfilter-persistent` :

```bash
netfilter-persistent flush
```

# Consulter les ports ouverts

```bash
# -n, --numeric            don't resolve names
# -e, --extend             display other/more information
# -p, --programs           affiche le nom du programme/PID des sockets
# -l, --listening          affiche les sockets du serveur à l'écoute
# -a, --all, --listening   affiche toutes les prises (défaut: connectés)
# --inet                   affiche uniquement les connexions de type net (udp/tcp, etc.)
netstat --inet -nplae
```

# Références

- [Wiki Debian iptables](https://wiki.debian.org/iptables)
