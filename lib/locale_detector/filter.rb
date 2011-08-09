module LocaleDetector
  module Filter
    extend ActiveSupport::Concern

    included do
      prepend_before_filter :set_locale
    end

    protected

    def set_locale
      I18n.locale = begin
        request.env['HTTP_ACCEPT_LANGUAGE'].split(/\s*,\s*/).collect do |l|
          l += ';q=1.0' unless l =~ /;q=\d+\.\d+$/
          l.split(';q=')
        end.sort do |x,y|
          raise "Incorrect format" unless x.first =~ /^[a-z\-]+$/i
          y.last.to_f <=> x.last.to_f
        end.first.first.gsub(/-[a-z]+$/i, '').downcase
      rescue # rescue (anything) from the malformed (or missing) accept language headers
        LocaleDetector.fallback_locale
      end
    end
  end
end
