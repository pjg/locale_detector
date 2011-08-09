module LocaleDetector
  module Filter
    extend ActiveSupport::Concern

    included do
      prepend_before_filter :set_locale
    end

    protected

    def set_locale
      I18n.locale = 'en'
    end
  end
end
