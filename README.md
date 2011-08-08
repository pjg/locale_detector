# Locale Detector

This Rails gem makes use of the HTTP_ACCEPT_LANGUAGE http header send by the browser with every request, to set the I18n.locale.

If there is no such header it will fall back to the default header.


## Installation

Install the gem

```bash
$ gem install locale_detector
```

add it to the Gemfile

```ruby
gem 'locale_detector'
```

and bundle

```bash
$ bundle
```


Copyright © 2011 Exvo.com Development BV, released under the MIT license
