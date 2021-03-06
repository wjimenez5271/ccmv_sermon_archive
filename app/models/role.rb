# == Schema Information
#
# Table name: roles
#
#  id             :integer         not null, primary key
#  name           :string(255)
#  superuser      :boolean
#  manage_roles   :boolean
#  add_sermons    :boolean
#  edit_sermons   :boolean
#  delete_sermons :boolean
#  add_edit_users :boolean
#  delete_users   :boolean
#  created_at     :datetime        not null
#  updated_at     :datetime        not null
#

class Role < ActiveRecord::Base
  attr_protected :superuser
  validates :name, presence: true

  def allowed_to?(action)
    if self.superuser
      true
    else
      self.send(action)
    end
  end

end
