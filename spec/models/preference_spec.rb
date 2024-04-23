# == Schema Information
#
# Table name: preferences
#
#  id      :bigint           not null, primary key
#  name    :string
#  value   :string
#  user_id :bigint
#
# Indexes
#
#  index_preferences_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Preference, type: :model do
  before :each do
    @current_user = User.create!(email: "user@example.com", name: "Normal User", role: "ROLE_USER", id: 1)
    @admin_user = User.create!(email: "admin@example.com", name: "Admin User", role: "ROLE_ADMIN", id: 2)
    @other_user = User.create!(email: "other@example.com", name: "Other User", role: "ROLE_USER", id: 3)

    @user_pref = Preference.create!(name: "User Preference", value: "User Value", user_id: 1)
    @admin_pref = Preference.create!(name: "Admin Preference", value: "Admin Value", user_id: 2)
    @other_pref = Preference.create!(name: "Other Preference", value: "Other Value", user_id: 3)
  end

  describe 'security' do
    it 'allows user to edit their own preferences' do
      ability = Ability.new(@current_user)
      assert ability.can?(:edit, @user_pref)
      assert ability.cannot?(:create, @user_pref)
      assert ability.cannot?(:delete, @user_pref)
    end

    it 'disallows normal user to edit admin\'s preferences' do
      ability = Ability.new(@current_user)
      assert ability.cannot?(:update, @admin_pref)
    end

    it 'disallows normal user to edit another user\'s preferences' do
      ability = Ability.new(@current_user)
      assert ability.cannot?(:update, @other_pref)
    end

    it 'allows admin to create or delete a preference from list' do
        ability = Ability.new(@admin_user)
        assert ability.can?(:create, @user_pref)
        assert ability.can?(:delete, @user_pref)
    end
  end
end
