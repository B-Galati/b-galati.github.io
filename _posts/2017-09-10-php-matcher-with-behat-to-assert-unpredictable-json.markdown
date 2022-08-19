---
title: PHP Matcher with Behat to assert unpredictable Json
date: 2017-09-10T17:28:08+00:00
layout: post
excerpt:
categories: blog
tags: ["Behat", "testing"]
---

[PHP Matcher](https://github.com/coduo/php-matcher) is an awesome library to do assertion against unpredictable data. Combined with [Behat](http://behat.org/) and the [Behatch contexts](https://github.com/Behatch/contexts) it's the perfect tool to test for non-deterministic JSON payload.

Here is an example where I override a method of Behatch `JsonContext` to add PHP Matcher features:

```php
<?php

use Behat\Gherkin\Node\PyStringNode;
use Behat\Mink\Exception\ExpectationException;
use Behatch\Context\JsonContext as BehatchJsonContext;
use Coduo\PHPMatcher\PHPMatcher;

class JsonContext extends BehatchJsonContext
{
    public function theJsonShouldBeEqualTo(PyStringNode $content)
    {
        $actual = $this->getJson();

        // Replace all useless whitespace
        // You can use the \Behatch\Json\Json class to have the same behavior
        // but it checks JSON syntax which could be problematic if you want to get rid
        // of double quote in field value
        $expected = preg_replace('/\s(?=([^"]*"[^"]*")*[^"]*$)/', '', $content->getRaw());

        if (!PHPMatcher::match((string) $actual, (string) $expected, $error)) {
            throw new ExpectationException($error, $this->getSession());
        }
    }
}
```

Then you need to use this context in your `behat.yml.dist` instead of the one provided by Behatch:

```yaml
default:
    suites:
        default:
            contexts:
                - JsonContext
```

Now, all your feature files can use PHP Matcher features like the following:

```feature
Feature:
  Scenario: Client credentials authentication
    When I send a "GET" request to "/foo"
    Then the response should be in JSON
    And the header "Content-Type" should be equal to "application/json"
    And the response status code should be 200
    And the JSON should be equal to:
    """
    {
      "bar":"@uuid@"
    }
    """
```

Let me know in the comment section below if you know any other alternative ;-)
