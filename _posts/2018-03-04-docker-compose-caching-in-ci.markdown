---
title: docker-compose-caching-in-CI
date: 2018-03-04T09:07:28+01:00
title: A docker compose caching strategy for CI
layout: post
excerpt:
categories: blog
tags: ["docker", "docker-compose", "caching", "CI", "CircleCI"]
---

Let's say you have some great docker images for your dev/prod environment but
they are quite long to build, specially in a CI that you want as fast as possible.

If you have a docker registry available, you could avoid the pain of re-building them
completely every single time.

# Docker caching mechanism

The idea is to use the option `--cache-from` of `docker build` but with `docker-compose`
because I like managing as much things as possible with `docker-compose`.

The problem that needs to be solved first is : how can I have a proper docker tag to avoid
having to re-build the whole image when the CI ran ?

The solution is simple: generate a md5 hash of your docker image and dependencies
(E.g. config files, etc.).

Let's dive into the example to see how we can do this.

# The fictive example

Everything is simplified here to showcase the big picture in CircleCI. The
important parts are directly explained in the examples.

We start with `docker-compose.yml` file :

```yaml
version: "3.2"
    app:
      services:
        volumes:
            - .:/app
        # This is the image name that will be generated during the build
        # APP_DOCKER_IMAGE_MD5 is generated at runtime by the the CI
        # It is used for pulling and pushing
        image: ${APP_DOCKER_IMAGE_NAME}:${APP_DOCKER_IMAGE_MD5}
        build:
            context: docker/dev
            # Two images are used for caching
            # 1) A specific image hash to try to build the full image with the cache
            # 2) The last CI build to try reusing as much cache as possible when
            #    a brand new image needs to be built
            cache_from:
                - ${APP_DOCKER_IMAGE_NAME}:${APP_DOCKER_IMAGE_MD5}
                - ${APP_DOCKER_IMAGE_NAME}:ci
```

Here is the CircleCI config :

```yaml
version: 2

references:
    # Use CircleCI machine executor in order to use volumes
    configure_base: &configure_base
        machine:
            enabled: true
            image: circleci/classic:201711-01

    # This is the task which generate a md5 hash of the content of the docker directory
    # Basically it generates a md5 of all files in the "docker" directory, then put them
    # in a file called "docker.md5" and finally generates a md5 of this file.
    generate_docker_hashes: &generate_docker_hashes
        run: |
            test -e docker.md5 || find docker -type f -exec md5sum {} \; | sort -k 2 > docker.md5
            echo 'export APP_DOCKER_IMAGE_NAME=example/docker-caching' >> $BASH_ENV
            echo 'export APP_DOCKER_IMAGE_MD5=$(md5sum docker.md5 | cut -f1 -d" ")' >> $BASH_ENV

    authenticate_on_registry: &authenticate_on_registry
        run: docker login -u $DOCKER_LOGIN -p $DOCKER_PASSWORD

    # Let's try to get the image if it exists
    # The build job is responsible to pull the fallback image tag with "ci"
    build_docker_images: &build_docker_images
        run: |
            set -x
            docker-compose pull --ignore-pull-failures --parallel
            docker-compose build

jobs:
    build:
        <<: *configure_base
        steps:
            - checkout

            - *authenticate_on_registry
            # Try to pull, then build a new image if it is needed
            - *generate_docker_hashes
            - run: docker pull $APP_DOCKER_IMAGE_NAME:ci || true
            - *build_docker_images
            # Build is done. We tag the (perhaps new) image
            # with "ci" (ie. the last built version) and push.
            - run: |
                set -x
                docker tag ci $APP_DOCKER_IMAGE_NAME:$APP_DOCKER_IMAGE_MD5
                docker-compose push

    unit-test:
        <<: *configure_base
        steps:
            - *generate_docker_hashes
            - *authenticate_on_registry
            - *build_docker_images
            # Run tests now

workflows:
    version: 2
    build_test_deploy:
        jobs:
          - build

          - tests:
              requires:
                - build
```

# Conclusion

That's it. We just see how to build docker images pragmatically in the CI for
your tests.

The major downside is that the CI would still need more time to execute than a
CI without docker, because yes, it's an overhead.

The big benefit is that you can reuse any known environment (I.e. dev, prod, etc.)
in your CI for your tests or anything. So you would be almost sure that what is working
on your machine would work the same way in your CI.

I recently came across this problem. I was trying to add Selenium tests to the CI
and it was a real pain. Then I switch to this approach and everything was smooth, almost :-)
