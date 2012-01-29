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

require 'spec_helper'

describe Role do
  pending "add some examples to (or delete) #{__FILE__}"
end
