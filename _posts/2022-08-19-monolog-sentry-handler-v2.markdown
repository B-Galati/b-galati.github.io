---
date: 2022-08-19T16:42:49+02:00
title: Monolog Sentry handler v2 is out!
layout: post
excerpt:
categories: blog
tags: ["Sentry", "Open source", "PHP"]
---

Some weeks ago, I released a [new major version of Monolog Sentry handler](https://twitter.com/B_Galati/status/1553016326834343943)
and I thought it would be a good idea to share some insights about it; so, here we are 😃.

The main goal of this release was to support the new major version (v3) of PHP Sentry SDK.
Details about it are in the [release note](https://github.com/B-Galati/monolog-sentry-handler/releases/tag/2.0.0)
which contains pointers to the upgrade guide and more.

As a reminder this library is a Monolog Sentry Handler that displays Monolog logs as Sentry breadcrumbs.
Thus, with the right Monolog config you can end up with the screenshot below. It's practical
for debugging purposes to have all logs related to an error in your error tracking tool 👍.

![Sentry event example screenshot](/images/sentry-event-example.png)

Migrating the code to work with the new Sentry SDK was quick. The most time-consuming tasks were:
- Testing manually SDK changes
- Adding compatibility with the new version of Monolog (v3)
- Updating the doc to be compatible with the new version of the library and Symfony
- Migrating to GitHub actions: that was the 1st time for me

If you want to quickly try the library, you can use
the new [example repository](https://github.com/B-Galati/monolog-sentry-handler-example).

Note that the library can be used with the [official Symfony bundle](https://github.com/getsentry/sentry-symfony).
It is a bit easier to set up with the bundle, and it comes with more features by default.

Thanks again to [Grzegorz Korba](https://twitter.com/_Codito_) who initiated that work!
