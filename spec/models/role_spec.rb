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
  before do
    @role = Role.new( name: "User" )
  end
  subject { @role }

  it { should respond_to(:name) }
  it { should respond_to(:superuser) }
  it { should be_valid }

  describe "name is not present" do
    before { @role.name = " " }
    it { should_not be_valid }
  end

  columns = Role.column_names - [ "id", "superuser", "name", 
    "created_at", "updated_at" ]
  
  describe "allowed_to should heed superuser setting" do
    it { should respond_to(column) }

    columns.each do |column|
      [ false, true ].each do |super_setting|
        [ false, true ].each do |member_setting|
          @role.superuser = super_setting
          @role.send(column + "=", member_setting)
          it { @role.allowed_to?(column).should == 
            ( super_setting or member_setting ) }
        end
      end

    end
  end
end
