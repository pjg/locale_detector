require 'spec_helper'

describe LocaleDetector::Filter do

  def set_locale(opts = {})
    filter = Object.new.extend(LocaleDetector::Filter)
    request = double('request', :env => { 'HTTP_ACCEPT_LANGUAGE' => opts[:language] })
    filter.stub(:request).and_return(request)
    filter.send(:set_locale)
  end

  specify { set_locale(:language => nil).should eql(LocaleDetector.fallback_locale) }

  specify { set_locale(:language => 'pl').should eql('pl') }

  specify { set_locale(:language => 'pl-PL').should eql('pl') }

  specify { set_locale(:language => 'pl,en-us;q=0.7,en;q=0.3').should eql('pl') }

  specify { set_locale(:language => 'lt,en-us;q=0.8,en;q=0.6,ru;q=0.4,pl;q=0.2').should eql('lt') }

  specify { set_locale(:language => 'pl-PL;q=0.1,en-us;q=0.7,en;q=0.3').should eql('en') }

end
