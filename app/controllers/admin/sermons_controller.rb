require 'find'

class Admin::SermonsController < ApplicationController
  layout 'admin'
  def index
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def rescan_files
    speakers = {}
    speaker_names = [
      'Guillermo Careaga',
      'Jack Osorno',
      'Mark Eldridge',
      'Mike Duarte',
      'Phil Warden',
      'Rick Franks',
      'Rick Riggan',
      'Tosh Woods',
    ]

    @output = ""

    # Form initials from speaker names
    speaker_names.each do |name|
      initials = name.gsub(/[a-z ]/, '')
      speakers[ initials ] = name
    end

    # Hardcoded translations
    speakers[ 'RFm' ] = 'Rick Franks'
    speakers[ 'RFM' ] = 'Rick Franks'

    path = Rails.root.join( 'public', 'media' )
    regex = /([a-zA-Z]*)\/([A-Z]*)(\d{4})(\d{2})(\d{2})\.mp3/

    scanned = 0
    added = 0
    Find.find( path ) do |f|
      next if FileTest.directory?(f)
      match = f.to_s.match(regex)
      if match
        scanned += 1
        short_name = match[0]
        @output << "Processing #{short_name}\n"
        service, speaker_initials, year, month, day = match[1..5]
        service = service.titleize
       
        speaker_name = speakers[speaker_initials]
        if not speaker_name
          @output << "\tERROR: Unknown speaker initials #{speaker_initials}\n"
          next
        end
        speaker = Speaker.find_or_create_by_name(speakers[speaker_initials])

        date = Time.utc(year, month, day)
        sermon = Sermon.find_or_initialize_by_date_and_speaker_id(date, speaker.id)
        if sermon.new_record?
          sermon.audio_path = match[0]
          sermon.service = Service.find_or_create_by_name(service)
          sermon.save!
          @output << "\tCreated sermon data for #{short_name}\n"
          added += 1
        end
      else
        @output << "No regex match on #{short_name}\n"
      end
    end
    @output << "Scanned #{scanned} files, added #{added}\n"

    @output
  end
end
