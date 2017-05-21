---
layout: post
title: Install Powerline on Debian
excerpt:
date: 2016-09-06T08:21:55-04:00
modified: 2017-05-21T23:17:49-04:00
categories: blog
tags: ["debian", "zsh", "tmux", "vim"]
---

# Install Powerline

Recently, I wanted to install Powerline as simply as possible on Debian Jessie. Here is a my feedback.

- Activate backports in `/etc/apt/sources.list`

```bash
deb http://ftp.fr.debian.org/debian/ jessie-backports main contrib non-free
```

- Install Powerline

```bash
sudo apt update && sudo apt-get install -t jessie-backports powerline
```

Voila ! Powerline is installed (Yea, even my grand mother could have done it hahaha). Now we are going to see how you can use it with `zsh`, `tmux`, and `vim`.

# Powerline's settings with zsh, tmux and vim

The secret is the following : RTFM of Debian (`/usr/share/doc/powerline/README.Debian`).

On my part, I am using it like so (with some extra parameters compared to Debian doc to make sure everything is ok) :

- zsh

```bash
# ~/.zshrc
export TERM="xterm-256color"
source /usr/share/powerline/bindings/zsh/powerline.zsh
```

- tmux

```bash
# ~/.tmux.conf
run-shell "powerline-daemon -q" # Powerline recommends it but it's normally useless
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

I am sure you have noticed that each time we must set the 256 colors mode otherwise it cannot work.

To finish, all my personal config is my [dotfiles](https://github.com/b-galati/dotfiles) repository. Questions / Suggestions are welcomed ;-).
