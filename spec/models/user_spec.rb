# == Schema Information
#
# Table name: users
#
#  id          :bigint           not null, primary key
#  email       :string
#  email_token :string
#  hhash       :string
#  name        :string
#  role        :string
#  suspended   :boolean
#  token       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_users_on_email_token  (email_token)
#  index_users_on_token        (token)
#
require 'rails_helper'
include BCrypt

RSpec.describe User, type: :model do
  before :each do
    @users = User.create!([
        {
          name: "Admin Adminson",
          email: "admin@shef.ac.uk",
          hhash: Password.create("qwe"),
          role: "ROLE_ADMIN"
        }])
  end
  describe 'login' do
    it 'allows password hash comparison' do
      assert Password.new(@users[0].hhash) =="qwe"
    end

    it 'allows a token to be added' do
      @users[0].add_token
      assert @users[0].token != nil
    end

    it 'allows a confirmation email to be sent' do
      expect {User.send_confirm_email @users[0]}.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end

  describe 'security' do
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/testing.md
    it 'allows user to edit themselves' do
      current_user = Common.user
      ability = Ability.new(current_user)
  
      assert ability.can?(:edit, current_user)
    end

    it 'dissalows normal user to edit another user' do
      current_user = Common.user
      admin_user = Common.admin
      ability = Ability.new(current_user)
  
      assert ability.cannot?(:edit, admin_user)
    end

    it 'dissalows normal user to edit another user' do
      current_user = Common.admin
      other_user = Common.admin
      ability = Ability.new(current_user)
  
      assert ability.can?(:edit, other_user)
    end
  end
end
