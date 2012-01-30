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

require 'spec_helper'

describe User do
  before do
    @user = User.new( email: 'a@b.com', username: 'abcdef' )
    @user.role_id = 1
  end
  subject { @user }

  it { should be_valid }

  describe 'when email is not present' do
    before { @user.email = ' ' }
    it { should_not be_valid }
  end

  describe 'when username is not present' do
    before { @user.username = ' ' }
    it { should_not be_valid }
  end

  describe 'when role_id is not present' do
    before { @user.role_id = nil }
    it { should_not be_valid }
  end

  describe 'when mass assignment is done on role_id' do
    it 'should raise an error' do
      expect{ User.new( email:'a@bcom', username: 'abc', role_id: 1 ) }.to \
        raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end
end
