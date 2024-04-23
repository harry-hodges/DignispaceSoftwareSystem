# == Schema Information
#
# Table name: bubbles
#
#  id            :bigint           not null, primary key
#  name          :string
#  user_group_id :bigint
#
# Indexes
#
#  index_bubbles_on_user_group_id  (user_group_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_group_id => user_groups.id)
#
require 'rails_helper'

RSpec.describe Bubble, type: :model do
  before :each do
    @user_group = UserGroup.create!(content_released: true, image: "image", name: "name")
    @bubble = Bubble.create!(name: "bubble name", user_group: @user_group)

    @current_user = User.create!(email: "user@example.com", name: "Normal User", role: "ROLE_USER")
    @viewer = User.create!(email: "viewer@example.com", name: "Friends & Family", role: "ROLE_VIEWER")

    UserRole.create!(user: @current_user, user_group: @user_group, role: "ROLE_PATIENT")
    UserRole.create!(user: @viewer, user_group: @user_group, role: "ROLE_VIEWER")
end

  describe 'security' do
    it 'allows patient to read, create and edit their bubble' do
      ability = Ability.new(@current_user)
      # assert ability.can?(:read, @bubble) Handled by testing user group access
      assert ability.can?(:update, @bubble)
      assert ability.can?(:create, Bubble)
    end

    it 'allows viewer to read a bubble but not edit or create' do
      ability = Ability.new(@viewer)
      # assert ability.can?(:read, @bubble) Handled by testing user group access
      assert ability.cannot?(:update, @bubble)
      assert ability.cannot?(:create, Bubble.new(user_group: @user_group))
    end

  end
end
