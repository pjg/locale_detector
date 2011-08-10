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

        # parse request.host and try to set the locale based on toplevel domain suffix (for netbots mostly)
        suffix = request.host.split('.').last

        # somewhat incomplete list of more common toplevel domains
        if [:bg, :be, :cn, :cz, :da, :de, :es, :et, :fi, :fr, :gr, :hi, :hr, :hu, :is, :it, :jp, :ko, :lv, :lt,
            :mk, :nl, :no, :pl, :pt, :ro, :ru, :se, :sr, :sk, :sl, :tr, :vi, :ua].include?(suffix.to_sym)
          suffix
        # some common international/English domains
        elsif [:eu, :uk, :us].include?(suffix.to_sym)
          'en'
        # Spanish speaking countries
        elsif [:ar, :cl, :co, :cu, :mx].include?(suffix.to_sym)
          'es'
        # Portuguese speaking countries
        elsif suffix == 'br'
          'pt'
        # fall back for .com and all other domains
        else
          I18n.default_locale.to_s
        end
      end
    end
  end
end
