namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
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

    100.times do |n|
      month = n/30 + 1
      day = n % 30 + 1
      date = Time.utc( 2012, month, day )
      Sermon.create!(date: date,
                     audio_path: "file#{n}.mp3",
                     speaker: speakers[ n % speakers.length ] )

    end
  end
end
