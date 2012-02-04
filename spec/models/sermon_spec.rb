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
#  service_id :integer
#

require 'spec_helper'

describe Sermon do
  subject { Sermon.new( date: '12/11/2011', title: 'A Sermon',
                        audio_path: 'abc.mp3' ) }

  it { should be_valid }

  it { should have_and_belong_to_many :tags }
  it { should belong_to :speaker }
  it { should belong_to :service }

  it { should validate_presence_of :date }
  it { should validate_presence_of :audio_path }

  it { should respond_to :speaker_name }
  it { should handle_name_for_nil_reference :speaker }
  it { should respond_to :service_name }
  it { should handle_name_for_nil_reference :service }

  it { Sermon.should respond_to :prefetch_refs }
  # Make sure that we're doing eager loading on service and speaker
  it { Sermon.prefetch_refs.eager_loading?.should == true }
  it { Set.new(Sermon.prefetch_refs.joined_includes_values).should == \
    Set.new([:service, :speaker]) }

end
