# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

require "locale_detector/version"

Gem::Specification.new do |s|
  s.name        = "locale_detector"
  s.version     = LocaleDetector::VERSION
  s.authors     = ["Paweł Gościcki"]
  s.email       = ["pawel.goscicki@gmail.com"]
  s.homepage    = "https://github.com/Exvo/locale_detector"
  s.summary     = "Rails gem setting the I18n.locale based on user's browser language"
  s.description = "Parses HTTP_ACCEPT_LANGUAGE http header and sets the I18n.locale based on that"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.licenses = ['MIT']

  s.add_dependency 'rails', ['>= 3.0.0']
  s.add_dependency 'i18n', ['>= 0.5.0']
  s.add_development_dependency 'guard', ['>= 0.5.0']
  s.add_development_dependency 'guard-rspec', ['>= 0.4.0']
  s.add_development_dependency 'rspec', ['>= 2.6']
  s.add_development_dependency 'rspec-rails', ['>= 2.6']
end
