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
#

class Sermon < ActiveRecord::Base
  has_and_belongs_to_many :tags
  belongs_to :speaker

  validates :date, presence: true
  validates :audio_path, presence: true
  validates :speaker_id, presence: true
end
