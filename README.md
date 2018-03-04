# How-to

```bash
# Set up environment variables
export DOCKER_UID=$(id -u)
export DOCKER_GID=$(id -g)

mkdir bundle # avoir permission issue with docker

bin/app bundle install
bin/app bundle exec jekyll build --drafts # compile the website

docker-compose up # watch any updates
```

# Useful commands

```bash
bin/app bundle exec octopress new draft <draft-name>
bin/app bundle exec octopress publish _drafts/<filename>.md

# Generate date with the right format
php -r "echo date(DATE_ATOM);"
```

Credit [So Simple Theme](https://github.com/mmistakes/so-simple-theme/)

# References

- [Versions github-pages](https://pages.github.com/versions/)
- [Setting up github-pages](https://help.github.com/articles/setting-up-your-github-pages-site-locally-with-jekyll/#keeping-your-site-up-to-date-with-the-github-pages-gem)
