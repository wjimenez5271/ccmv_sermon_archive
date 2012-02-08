namespace :db do
  desc "Fill database with sample data"
  task :sample_data => :environment do
    Rake::Task['db:reset'].invoke
    
    speaker_names = [ "Rick Franks",
      "Guillermo Careaga",
      "Phil Warden",
      "Tosh Woods",
      "Mark Eldridge",
      "Mike Duarte",
      "Jack Osorno" ]

    speakers = []

    speaker_names.each do |name|
      speakers << Speaker.create!(name: name)
    end

    services = []
    services << Service.create!(name: "Thursday")
    services << Service.create!(name: "Sunday")

    100.times do |n|
      month = n/30 + 1
      day = n % 30 + 1
      date = n.days.ago
      Sermon.create!(date: date,
                     audio_path: "file#{n}.mp3",
                     speaker: speakers[ n % speakers.length ],
                     service: services[ n % services.length ])

    end
  end
end
