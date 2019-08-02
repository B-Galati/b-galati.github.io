---
layout: post
title: "Convert PGS subtitles (Blu-ray .sup) to VobSub (DVD .idx/.sub)"
date: 2015-12-13T20:48:07+00:00
modified: 2019-07-25T08:56:33+02:00
excerpt:
categories: blog
tags: ["multimedia", "linux", "subtitles"]
---

Following a problem with my TV which did not want to read Blu-ray subtitles, I had to find a way to convert them in an understandable format.
So I used the following tools:

- __mkvtoolnix__ (CLI tool for MKV files)
- __mkvtoolnix-gui__ (GUI for mkvtoolnix)
- __BDSupToSub__ (to convert PGS subtitles to VobSub)

# First step: extract subtitles

- Identity track number with `mkvinfo` (here it's 5):

```bash
mkvinfo <filename>

[...]
| + One track
|  + Track number : 6 (track number for mkvmerge & mkvextract would be 5)
|  + Track UID : 9788501119646790547
|  + Type of track : subtitles
|  + Default signal : 0
|  + Forced signal : 1
|  + Codec ID : S_HDMV/PGS
[...]
```

- Extract identified track (example with number 5):

```bash
mkvextract tracks <input_filename> 5:<output_filename.sup>
```

# Second step: convert track from SUP to VobSub

We use BDSup2Sub for this (Download [here](https://github.com/mjuhasz/BDSup2Sub/wiki/Download)):

- Start BDSup2Sub

```bash
java -jar BDSup2Sub.jar
```

- Load subtitles file to convert with _« File -> Load »_

- Let default options and start conversion with _« File -> Save/Export »_



# Third step: (optional) multiplex tracks

On my end my TV only read default subtitle built-in the MKV file. That's why I had to put the track back into the video. To do this, I used __MKVToolNix GUI__. It's very simple to use, here is example:

![Image Alt](/images/MKVToolNixGUI-exemple-multiplexage-mkv-vobsub.png)

That's the end, let me know in the comment section below for anything !


# References

- [GitHub de BDSup2Sub (Download on wiki page)](https://github.com/mjuhasz/BDSup2Sub)
- [SubExtractor: for SRT subtitles](https://subextractor.codeplex.com/)
- [Avidemux: same](http://en.flossmanuals.net/Avidemux/ExtractingDVDSubtitles/)
