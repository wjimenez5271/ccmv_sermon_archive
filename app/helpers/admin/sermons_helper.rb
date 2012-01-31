require 'find'

module Admin::SermonsHelper
  module_function
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
        service, speaker_initials, year, month, day = match[1..5]
        service = service.titleize
       
        speaker_name = speakers[speaker_initials]
        if not speaker_name
          Rails.logger.error 'Unknown speaker initials ' + speaker_initials
          next
        end
        speaker = Speaker.find_or_create_by_name(speakers[speaker_initials])

        date = Time.utc(year, month, day)
        sermon = Sermon.find_or_initialize_by_date_and_speaker_id(date, speaker.id)
        if sermon.new_record?
          sermon.audio_path = match[0]
          sermon.service = Service.find_or_create_by_name(service)
          sermon.save!
          Rails.logger.info 'Created sermon data for ' + f
          added += 1
        end
      else
        Rails.logger.warn "No regex match on " + f
      end
    end
    Rails.logger.info "Scanned #{scanned} files, added #{added}"
  end
end
