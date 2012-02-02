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
  subject { Role.new( name: "User" ) }

  it { should respond_to(:name) }
  it { should respond_to(:superuser) }
  it { should be_valid }

  describe "name is not present" do
    it do
      subject.name = " "
      should_not be_valid
    end
  end

  # All columns that represent individual permissions
  columns = Role.column_names - [ "id", "superuser", "name", 
    "created_at", "updated_at" ]
  
  columns.each do |column|
    it { should respond_to(column) }
    [ false, true ].each do |super_setting|
      [ false, true ].each do |member_setting|
        it "allowed_to?(#{column}) should work when #{column} is " \
                  "#{member_setting}, superuser is #{super_setting}" do
          subject.superuser = super_setting
          subject.send(column + "=", member_setting)
          subject.allowed_to?(column).should ==
            ( super_setting or member_setting )
        end
      end
    end

  end
end
