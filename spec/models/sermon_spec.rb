# == Schema Information
#
# Table name: sermons
#
#  id            :integer         not null, primary key
#  title         :string(255)
#  date          :date
#  summary       :string(255)
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#  audio_path    :string(255)
#  speaker_id    :integer
#  service_id    :integer
#  book_id       :integer
#  start_chapter :integer
#  end_chapter   :integer
#  start_verse   :integer
#  end_verse     :integer
#

require 'spec_helper'

describe Sermon do
  before(:all) do
    @books = Array.new(2) { FactoryGirl.create(:book) }
  end
  after(:all) do
    Book.delete_all
  end
  subject { Sermon.new( date: '12/11/2011', title: 'A Sermon',
                        audio_path: 'abc.mp3' ) }

  it { should be_valid }

  it { should have_and_belong_to_many :tags }
  it { should belong_to :speaker }
  it { should belong_to :service }
  it { should belong_to :book }

  it { should validate_presence_of :date }
  it { should validate_presence_of :audio_path }

  it { should respond_to :speaker_name }
  it { should handle_name_for_nil_reference :speaker }
  it { should respond_to :service_name }
  it { should handle_name_for_nil_reference :service }
  it { should respond_to :book_name }
  it { should handle_name_for_nil_reference :book }

  it { Sermon.should respond_to :prefetch_refs }
  # Make sure that we're doing eager loading on service and speaker
  it { Sermon.prefetch_refs.eager_loading?.should == true }
  it { Set.new(Sermon.prefetch_refs.joined_includes_values).should == \
    Set.new([:service, :speaker]) }

  describe "passage handling" do
    it "returns nil without a book" do
      subject.passage.should == nil
    end
    it "returns nil without a book but with other data" do
      subject.start_verse = 1
      subject.end_verse = 2
      subject.start_chapter = 1
      subject.end_chapter = 2
      subject.passage.should == nil
    end

    it "handles only book set" do
      subject.book = @books[0]
      subject.passage.should == @books[0].name
    end

    it "handles only book and start_verse" do
      subject.book = @books[0]
      subject.start_verse = 1
      subject.passage.should == "#{@books[0].name} 1"
    end

    it "handles start_verse == end_verse" do
      subject.book = @books[0]
      subject.start_verse = 1
      subject.end_verse = 1
      subject.passage.should == "#{@books[0].name} 1"
    end

    it "does start_verse and end_verse" do
      subject.book = @books[0]
      subject.start_verse = 1
      subject.end_verse = 2
      subject.passage.should == "#{@books[0].name} 1-2"
    end

    it "does start_chapter with verses" do
      subject.book = @books[0]
      subject.start_verse = 1
      subject.end_verse = 2
      subject.start_chapter = 1
      subject.passage.should == "#{@books[0].name} 1:1-2"
    end

    it "does start_chapter == end_chapter" do
      subject.book = @books[0]
      subject.start_verse = 1
      subject.end_verse = 2
      subject.start_chapter = 1
      subject.end_chapter = 1
      subject.passage.should == "#{@books[0].name} 1:1-2"
    end

    it "does full data" do
      subject.book = @books[0]
      subject.start_verse = 1
      subject.end_verse = 2
      subject.start_chapter = 1
      subject.end_chapter = 2
      subject.passage.should == "#{@books[0].name} 1:1-2:2"
    end

    it "does no start_verse" do
      subject.book = @books[0]
      subject.end_verse = 2
      subject.start_chapter = 1
      subject.end_chapter = 2
      subject.passage.should == "#{@books[0].name} 1-2:2"
    end

    it "does no end_verse" do
      subject.book = @books[0]
      subject.start_verse = 1
      subject.start_chapter = 1
      subject.end_chapter = 2
      subject.passage.should == "#{@books[0].name} 1:1-2"
    end

  end
end
