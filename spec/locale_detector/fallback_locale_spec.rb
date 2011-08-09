require 'spec_helper'

describe LocaleDetector do

  subject { LocaleDetector.fallback_locale }

  it { should_not be_empty }

end
