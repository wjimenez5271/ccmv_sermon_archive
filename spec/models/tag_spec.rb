# == Schema Information
#
# Table name: tags
#
#  id   :integer         not null, primary key
#  name :string(255)
#

require 'spec_helper'

describe Tag do
  it { should have_and_belong_to_many :sermons }
end
