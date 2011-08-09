require "locale_detector/fallback_locale"
require "locale_detector/filter"
require "locale_detector/version"

# Make it a Railtie
module LocaleDetector
  require 'locale_detector/railtie' if defined?(Rails)
end
