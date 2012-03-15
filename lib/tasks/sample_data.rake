namespace :db do
  desc "Fill database with sample data"
  task :sample_data => :environment do
    Rake::Task['db:reset'].invoke
    
    speaker_names = [ 
      "Phil Warden",
      "Rick Franks",
      "Guillermo Careaga",
      "Tosh Woods",
      "Mark Eldridge",
      "Mike Duarte",
      "Jack Osorno" ]

    speakers = []

    speaker_names.each do |name|
      speakers << Speaker.create!(name: name.downcase)
    end

    services = []
    services << Service.create!(name: "thursday")
    services << Service.create!(name: "sunday")

    100.times do |n|
      month = n/30 + 1
      day = n % 30 + 1
      date = n.days.ago
      data =  { date: date,
        audio_path: "file#{n}.mp3",
        speaker: speakers[ n % speakers.length ],
        service: services[ n % services.length ],
        book_id: ( n % 20 ) * 3 + 1,
        title: "Title #{n}" }
      if n % 20 != 0
        data[:start_chapter] = n % 5 + 1

        if n % 3 == 1
          data[:end_chapter] = n % 5 + 2
        elsif n % 3 == 2
          data[:end_chapter] = data[:start_chapter]
        end

        if n % 8 != 0
          data[:start_verse] = n % 8 + 1
          if n % 16 != 0
            data[:end_verse] = n % 8 + 2
          end
        end
      elsif n % 40 == 0
        data[:start_verse] = 1
        if n % 80 == 0
          data[:end_verse] = 2
        end
      end

      Sermon.create!(data)
    end
  end
end
