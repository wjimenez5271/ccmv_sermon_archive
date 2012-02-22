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

class Sermon < ActiveRecord::Base
  has_and_belongs_to_many :tags
  belongs_to :speaker
  belongs_to :service
  belongs_to :book

  validates :date, presence: true
  validates :audio_path, presence: true

  delegate :name, to: :speaker, prefix: true, allow_nil: true
  delegate :name, to: :service, prefix: true, allow_nil: true
  delegate :name, to: :book, prefix: true, allow_nil: true

  scope :prefetch_refs, includes(:speaker, :service).joins(:speaker, :service)

  def passage
    p = book_name
    return p if not p

    p = String.new(p)

    if not start_chapter?
      if start_verse?
        p << " #{start_verse}"
      end

      if end_verse? and start_verse != end_verse
        p << "-#{end_verse}"
      end

      return p
    end

    p << " #{start_chapter}"

    if start_verse?
      p << ":#{start_verse}"
    end

    if end_chapter? and start_chapter != end_chapter
      p << "-#{end_chapter}"
      if end_verse?
        p << ":#{end_verse}"
      end
    elsif end_verse? and end_verse != start_verse
      p << "-#{end_verse}"
    end

    p
  end
end
