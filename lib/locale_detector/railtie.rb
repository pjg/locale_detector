require 'locale_detector'
require 'rails'

module LocaleDetector
  class Railtie < Rails::Railtie
    initializer "locale_detector.append_before_filter" do
      ActiveSupport.on_load(:action_controller) do
        ActionController::Base.send(:include, LocaleDetector::Filter)
      end
    end
  end
end
