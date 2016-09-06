---
layout: post
title: Installer Powerline sur Debian Jessie
excerpt:
date: 2016-09-06T08:21:55-04:00
categories: blog
tags: ["debian", "zsh", "tmux", "vim"]
---

# Installer Powerline

Récemment, j'ai voulu installer powerline de la façon la plus simple possible. Je vous fais un compte-rendu.

- Activer le dépôt backports en ajoutant cette ligne dans le fichier `/etc/apt/sources.list`

```bash
deb http://ftp.fr.debian.org/debian/ jessie-backports main contrib non-free
```

- Installer Powerline

```bash
sudo apt update && sudo apt-get install -t jessie-backports powerline
```

Et voilà ! Powerline est installé sur la machine (Oui je sais, même ma grand-mère aurait pu le faire hahaha). Maintenant on va voir comment en profiter avec `zsh`, `tmux`, et `vim`.

# Configuration de powerline avec zsh, tmux et vim

Je vous donne tout de suite le secret. Il faut lire la doc que les mainteneurs du paquet ont créé :  `/usr/share/doc/powerline/README.Debian`.

Voilà ce que ça donne chez moi, avec quelques ajouts pour être sûr que tout fonctionne bien :

- zsh

```bash
# ~/.zshrc
export TERM="xterm-256color"
source /usr/share/powerline/bindings/zsh/powerline.zsh
```

- tmux

```bash
# ~/.tmux.conf
run-shell "powerline-daemon -q" # C'est conseillé par la doc de powerline mais pas utile normalement
source "/usr/share/powerline/bindings/tmux/powerline.conf"
set -g default-terminal "screen-256color"
```

- vim

```
" ~/.vimrc
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup
set laststatus=2 " Always show statusline
set t_Co=256
```

Vous remarquerez qu'il faut systématiquement préciser que l'on veut utiliser le mode 256 couleurs sinon ça ne fonctionnera pas.

Pour terminer, toute ma configuration perso se trouve sur mon dépôt [dotfiles](https://github.com/b-galati/dotfiles). Les questions/améliorations sont les bienvenues !
