require 'spec_helper'

describe Admin::MainHelper do
  it { helper.admin_full_title('').should == 'CCMV Sermon Archive Admin' }
  it { helper.admin_full_title('AbCd').should == 'CCMV Sermon Archive Admin | AbCd' }
end
