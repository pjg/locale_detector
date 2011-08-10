# Locale Detector

This Rails gem makes use of the HTTP_ACCEPT_LANGUAGE http header sent by web browsers with every request, to set the `I18n.locale` setting.

When this fails (for example if there is no such http header - as is the case for Google bot), it will try to determine the locale based on the toplevel domain suffix (so it will set `'de'` for the `example.de` domain).

When both fail, it will fall back to `I18n.default_locale`, which should be set in application’s `config/application.rb` file (and is `'en'` by default).

The HTTP_ACCEPT_LANGUAGE header parser is based on:
https://github.com/iain/http_accept_language/blob/master/lib/http_accept_language.rb


## Requirements

Rails 3.0+


## Example

When this gem is installed and someone visits your application using a Polish version of Firefox the following http header will be sent:

```
HTTP_ACCEPT_LANGUAGE: pl,en-us;q=0.7,en;q=0.3
```

and the `I18n.locale` will be set to `'pl'`.


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
