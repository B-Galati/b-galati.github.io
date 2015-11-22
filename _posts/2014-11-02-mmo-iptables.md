---
layout: post
title: "Mémo iptables"
date: 2014-11-02T16:28:55-04:00
categories: blog
tags: ["iptables","admin sys", "linux"]
---

Un petit résumé de ma modeste expérience avec iptables sur mon serveur.

# Backup/Restore

```bash
# Sauvegarde
sudo iptables-save > fichier_de_backup
# Restauration
sudo iptables-restore < fichier_de_backup
```

# Consultation des règles

```bash
# Règles forwarding
sudo iptables -t nat -L -n -v
# Toutes les règles
sudo iptables -L -n -v
```

# Création de règles

```bash
# Redirige tout le traffic TCP entrant sur le port 25, vers le port 2525
sudo iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 25 -j REDIRECT --to-port 2525
# Permet l’accès à internet aux personnes connectées sur le VPN
iptables -t nat -A POSTROUTING -s 192.168.0/24 -o eth0 -j MASQUERADE
```

# Références

* [Best practices iptables](http://major.io/2010/04/12/best-practices-iptables/)
* [Automatically loading iptables on debianubuntu](http://major.io/2009/11/16/automatically-loading-iptables-on-debianubuntu/)
