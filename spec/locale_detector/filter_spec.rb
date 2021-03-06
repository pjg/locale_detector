require 'spec_helper'

describe LocaleDetector::Filter do

  def set_locale(opts = {})
    filter = Object.new.extend(LocaleDetector::Filter)

    request =
      if opts[:language].present?
        double('request', :env => { 'HTTP_ACCEPT_LANGUAGE' => opts[:language] })
      elsif opts[:host].present?
        double('request', :env => nil, :host => opts[:host])
      end

    session =
      if opts[:session_language].present?
        double('session', :[] => opts[:session_language])
      else
        double('session', :[] => '')
      end

    filter.stub(:session).and_return(session)
    filter.stub(:request).and_return(request)
    filter.send(:set_locale)
  end

  context "session[:language] locale overwrite" do
    specify { set_locale(:language => 'pt-BR', :session_language => 'pl').should eql('pl') }
  end

  context "http header locale setting" do
    specify { set_locale(:language => 'pl').should eql('pl') }

    specify { set_locale(:language => 'pl-PL').should eql('pl') }

    specify { set_locale(:language => 'pt-BR').should eql('pt') }

    specify { set_locale(:language => 'pl,en-us;q=0.7,en;q=0.3').should eql('pl') }

    specify { set_locale(:language => 'lt,en-us;q=0.8,en;q=0.6,ru;q=0.4,pl;q=0.2').should eql('lt') }

    specify { set_locale(:language => 'pl-PL;q=0.1,en-us;q=0.7,en;q=0.3').should eql('en') }
  end

  context "host based locale setting" do
    specify { set_locale(:host => 'example.pl').should eql('pl') }

    specify { set_locale(:host => 'example.co.uk').should eql('en') }

    specify { set_locale(:host => 'example.mx').should eql('es') }

    specify { set_locale(:host => 'example.br').should eql('pt') }

    specify { set_locale(:host => 'example.jp').should eql('ja') }

    specify { set_locale(:host => 'example.se').should eql('sv') }
  end

  context "default fallback" do
    before do
      I18n.default_locale = 'de'
    end

    specify { set_locale(:host => 'example.com').should eql('de') }
  end

end
