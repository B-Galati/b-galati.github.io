---
layout: post
title: "Convertir des sous-titres PGS (Bluray .sup) en VobSub (DVD .idx/.sub)"
date: 2015-12-13T20:48:07+00:00
excerpt:
categories: blog
tags: ["multimedia", "linux", "subtitles"]
---

Suite à un problème avec ma télé qui ne voulait pas lire les sous-titres bluray d'un film, j'ai dû trouver un moyen pour les convertir dans un format plus conventionel.
Pour ce faire, j'ai utilisé les outils suivant :

- __mkvtoolnix__ (ensemble d'outils en ligne de commandes pour traiter des fichiers MKV)
- __mkvtoolnix-gui__ (interface utilisateur de mkvtoolnix)
- __BDSupToSub__ (pour convertir les sous-titres en SRT classique)

# 1ère étape : extraire les sous-titres

- Identifier le numéro de la piste avec mkvinfo (ici c'est le numéro 5) :

```bash
$ mkvinfo <nom_du_fichier>

[...]
| + Une piste
|  + Numéro de piste : 6 (identifiant de piste pour mkvmerge & mkvextract : 5)
|  + UID de piste : 9788501119646790547
|  + Type de piste : subtitles
|  + Signal par défaut : 0
|  + Signal forcé : 1
|  + Signal de laçage : 0
|  + Identifiant du codec : S_HDMV/PGS
|  + Encodages du contenu
|   + Encodage du contenu
|    + Compression du contenu
[...]
```

- Extraire la piste qui a été identifiée (exemple avec la piste 5) :

```bash
$ mkvextract tracks <nom_du_fichier> 5:<fichier_sortie.sup>
```

# 2ème étape : convertir la piste SUP en VobSub

On utilisera BDSup2Sub (à télécharger [ici](https://github.com/mjuhasz/BDSup2Sub/wiki/Download)) :

- Démarrez BDSup2Sub

```bash
$ java -jar BDSup2Sub.jar
```

- Chargez le fichier de sous-titre à convertir via le menu _« File -> Load »_

- Laissez les options par défaut et démarrez la conversion via le menu _« File -> Save/Export »_



# 3ème étape : (optionnelle) multiplexer le tout

Pour ma part, ma télé ne lit que la piste de sous-titre par défaut embarquée dans le MKV. C'est pourquoi j'ai dû réintégrer la piste dans le fichier original. Pour ça, on utilisera __MKVToolNix GUI__. C'est assez simple d'utilisation, voici un exemple en image :

![Image Alt](/images/MKVToolNixGUI-exemple-multiplexage-mkv-vobsub.png)

Si vous avez besoin d'aide, n'hésitez pas à laisser un commentaire !


# Liens / Références

- [GitHub de BDSup2Sub (Allez sur le wiki pour le  télécharger)](https://github.com/mjuhasz/BDSup2Sub)
- [SubExtractor : pour ceux qui veulent des sous-titres au format texte  SRT](https://subextractor.codeplex.com/)
- [Avidemux : idem](http://en.flossmanuals.net/Avidemux/ExtractingDVDSubtitles/)
