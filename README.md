# How-to

```bash
# Set up environment variables
export DOCKER_UID=$(id -u)
export DOCKER_GID=$(id -g) 

# Créer le répertoire bundle s'il n'existe pas (évite des problème de permission avec docker)
mkdir bundle

# Installer les dépendances
bin/app bundle install

# Lancer le blog
docker-compose up
```

# Commandes utiles

```bash
bin/app bundle exec octopress new draft <draft-name>
bin/app bundle exec octopress publish _drafts/<filename>.md

# Compile tous les articles
bin/app bundle exec jekyll build
```

Credit [So Simple Theme](https://github.com/mmistakes/so-simple-theme/)

# Références

- [Versions github-pages](https://pages.github.com/versions/)
- [Setting up github-pages](https://help.github.com/articles/setting-up-your-github-pages-site-locally-with-jekyll/#keeping-your-site-up-to-date-with-the-github-pages-gem)
