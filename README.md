# Locale Detector

This Rails gem makes use of the HTTP_ACCEPT_LANGUAGE http header sent by web browsers with every request, to set the `I18n.locale` setting.

When this fails (for example if there is no such http header - as is the case for Google bot), it will try to determine the locale based on the toplevel domain suffix (so it will set `'de'` for the `example.de` domain).

When both fail, it will fall back to `I18n.default_locale`, which should be set in application’s `config/application.rb` file (`'en'` by default).

The HTTP_ACCEPT_LANGUAGE header parser is based on:
https://github.com/iain/http_accept_language/blob/master/lib/http_accept_language.rb

The best way to use this gem is to combine it either with the [exvo_globalize gem](https://github.com/Exvo/exvo_globalize/) or any other I18n gem/configuration, which supports falling back to `default_locale` for `I18n.translate()` calls when the translation is not found in the desired language. This enables you to have the `I18n.locale` set to `:jp` but still display everything in English (for example) if you don’t have the Japanese translation of your web application.



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


## Caveats

Locale autodetection is done via a `before_filter` called `set_locale`, which is run before every controller action when you bundle this gem. Beware, that the `set_locale` filter will most likely be run **first**, before your other application defined filters, so if you’d like to update the `session[:language]` in your `before_filter` (to reflect the change of display language by the user) you have to place a call to `set_locale` just after setting the `sessinon[:language]` (also see the notes below on "Turning off the language detection").



## Turning off the language autodetection

In certain cases we might want to turn off the locale/language autodetection. For example, we might want to give the user the ability to set his preferred language in his profile and respect this setting.

In order to do that, you need to set a `:language` session key in your app:

```ruby
session[:language] = 'pl'
```

In consequence, regardless of the user browser’s language, the `I18n.locale` will be set to `'pl'`.


Exemplary controller code for letting the user set his desired display language follows (note, that we have an empty language <option> with the display value "Autodetect (browser language)", which the user can choose).

```ruby
class UsersController < ApplicationController

  def update
    if @user.update_attributes(params[:user])
      if @user.language.present?
        # set I18n.locale based on user’s preference
        I18n.locale = session[:language] = @user.language
      else
        # clear session language and autodetect the locale
        session.delete(:language)
        set_locale
      end

      ...
    end
  end

end
```



Copyright © 2011 Exvo.com Development BV, released under the MIT license
