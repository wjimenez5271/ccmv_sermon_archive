# == Schema Information
#
# Table name: tags
#
#  id   :integer         not null, primary key
#  name :string(255)
#

class Tag < ActiveRecord::Base
  has_and_belongs_to_many :sermons
end
