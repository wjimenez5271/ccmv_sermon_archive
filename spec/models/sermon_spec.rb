# == Schema Information
#
# Table name: sermons
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  date       :date
#  passage    :string(255)
#  summary    :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  audio_path :string(255)
#  speaker_id :integer
#

require 'spec_helper'

describe Sermon do
  before do
    @sermon = Sermon.new( date: '12/11/2011', title: 'A Sermon' )
  end
  subject { @sermon }

  it { should be_valid }

  describe 'when date is not present' do
    before { @sermon.date = nil }
    it { should_not be_valid }
  end
end
