# == Schema Information
#
# Table name: users
#
#  id              :integer         not null, primary key
#  email           :string(255)
#  username        :string(255)
#  password_digest :string(255)
#  role_id         :integer
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#

class User < ActiveRecord::Base
  belongs_to :role
  attr_accessible :email, :username
  attr_accessible :email, :username, :role_id, as: :admin

  validates :email, presence: true
  validates :username, presence: true
  validates :role_id, presence: true
end
