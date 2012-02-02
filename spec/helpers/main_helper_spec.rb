require 'spec_helper'

describe MainHelper do
  it { helper.full_title('').should == 'CCMV Sermon Archive' }
  it { helper.full_title('AbCd').should == 'CCMV Sermon Archive | AbCd' }
end
