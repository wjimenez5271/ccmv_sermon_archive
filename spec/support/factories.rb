FactoryGirl.define do
  factory :service do
    sequence(:name) { |n| "Service #{n}" }
  end

  factory :speaker do
    sequence(:name) { |n| "Speaker #{n}" }
  end

  factory :book do
    book_names = [ "Genesis", "Exodus", "Matthew", "Jude" ]
    sequence(:name) { |n| book_names[n] }
  end

  factory :sermon do |sermon|
    sequence(:date) { |n| n.days.ago }
    sequence(:audio_path) { |n| "file#{n}.mp3" }
    sermon.association :speaker
    sermon.association :service
    sermon.association :book
    sequence(:start_chapter) { |n| n }
    sequence(:end_chapter) { |n| n + 1 }
    sequence(:start_verse) { |n| n }
    sequence(:end_verse) { |n| n + 1 }
  end
end
