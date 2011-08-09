$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$:.unshift(File.dirname(__FILE__))

require 'rails'
require 'locale_detector'

RSpec.configure do |config|
  config.mock_with :rspec
end
