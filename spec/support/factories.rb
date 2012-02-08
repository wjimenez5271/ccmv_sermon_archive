FactoryGirl.define do
  factory :service do
    sequence(:name) { |n| "Service #{n}" }
  end

  factory :speaker do
    sequence(:name) { |n| "Speaker #{n}" }
  end

  factory :sermon do |sermon|
    sequence(:date) { |n| n.days.ago }
    sequence(:audio_path) { |n| "file#{n}.mp3" }
    sermon.association :speaker
    sermon.association :service
  end
end
