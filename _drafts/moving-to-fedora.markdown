---
title: TODO
---

I wanted to update to Ubuntu 20.04 but one my coworker alerts me that snapd is getting integrated at the APT level.

So event [disabling snapd](TODO) does not look to be enough.

Link my tweet.

In fact that's half serious as Linus and Rémi know what they are doing. They must be choosing a distribution for very good reasons. 

I am done experimenting shiny stuff that breaks every week or asking for a month of setup. I want something I can quickly work with efficiency in mind. Easy to upgrade and maintain.

I told myself that it is just a Linux distribution after all. Nothing personal With that. Just to learn another package managing system.

I am pretty confident fedora will not come up with something weird that will make me switch again to something else. It looks like they embrace standard setup as stock as possible without trying to add their own secret magic sauce.

Enough, it's not enough let's look to something else debian based because all my provision scripts are debian based. I didn't find anything that seduce me that is debian based actually. That's why I thought about Fedora.

My requirements are the following:
- Fast to setup
- Relatively up-to-date
- Stable
- Good and large community
- Secure? Whatever that means :P

Fedora looks to tick all the cases so le's go :D

It asks me to rework all my ansible config. I did it with great pleasure. For now, the Ansible script is compatible with both Fedora and Ubuntu.

Fedora is based on Red Hat Linux and is an upstream contributor to Red Hat Enterprise Linux.

Usefull tips and trick I leannt alon the way.
- RPM fusion is a must https://rpmfusion.org/
- Copr https://docs.pagure.org/copr.copr/#
- fedy https://github.com/rpmfusion-infra/fedy

In a future article I will show how I am backing up my config. Stay tuned.

https://fedoraproject.org/wiki/Differences_to_Ubuntu
https://www.maketecheasier.com/fedora-vs-ubuntu/
