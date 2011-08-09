# Locale Detector

This Rails gem makes use of the HTTP_ACCEPT_LANGUAGE http header sent by web browsers with every request, to set the `I18n.locale` setting.
When this fails (for example if there is no such http header - as is the case for Google bot), it will try to determine the locale based on the toplevel domain suffix (so it will set 'de' for the `example.de` domain).
When both fail, it will fall back to the `LocaleDetector.fallback_locale`, which is 'en' by default and can be overriden in `config/initializers/locale_detector.rb`.

The HTTP_ACCEPT_LANGUAGE header parser is based on:
https://github.com/iain/http_accept_language/blob/master/lib/http_accept_language.rb


## Requirements

Rails 3.0+


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


You can optionally overwrite the default fallback locale by creating a `config/initializers/locale_detector.rb` file and set the `fallback_locale` to a new string, for example:

```ruby
LocaleDetector.fallback_locale = 'pl'
```



Copyright © 2011 Exvo.com Development BV, released under the MIT license
