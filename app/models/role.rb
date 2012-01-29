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
end
