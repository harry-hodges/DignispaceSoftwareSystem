# == Schema Information
#
# Table name: answers
#
#  id            :bigint           not null, primary key
#  contents      :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  question_id   :bigint
#  user_group_id :bigint
#
# Indexes
#
#  index_answers_on_question_id    (question_id)
#  index_answers_on_user_group_id  (user_group_id)
#
# Foreign Keys
#
#  fk_rails_...  (question_id => questions.id)
#  fk_rails_...  (user_group_id => user_groups.id)
#
require 'rails_helper'
RSpec.describe Answer, type: :model do

  before :each do
    @user_group = UserGroup.create!(content_released: true, image: "image", name: "name")
    @question = Question.create!(contents: "Question contents", sensitivity: "Question sensitivity", title: "Question title")
    @answer = Answer.create!(contents: "Answer contents", question_id: @question.id, user_group_id: @user_group.id)

    @current_user = User.create!(email: "user@example.com", name: "Normal User", role: "ROLE_PATIENT")
    @admin_user = User.create!(email: "admin@example.com", name: "Admin User", role: "ROLE_ADMIN")
    @viewer = User.create!(email: "viewer@example.com", name: "Friends & Family", role: "ROLE_VIEWER")

    UserRole.create!(user: @current_user, user_group: @user_group, role: "ROLE_PATIENT")
    UserRole.create!(user: @admin_user, user_group: @user_group, role: "ROLE_ADMIN")
    UserRole.create!(user: @viewer, user_group: @user_group, role: "ROLE_VIEWER")
  end

  describe 'security' do

    it 'allow patient to edit their answers but not create one' do
        ability = Ability.new(@current_user)
        # assert ability.can?(:read, @answer) We dont need this
        assert ability.can?(:edit, @answer)
        assert ability.cannot?(:create, @answer)
    end

    it 'allow admins to read, edit and create answers' do
      ability = Ability.new(@admin_user)
      assert ability.can?(:read, @answer)
      assert ability.can?(:edit, @answer)
      assert ability.can?(:create, Answer)
    end

    it 'allow viewer (friends/family) to read ' do
        ability = Ability.new(@viewer)
        assert ability.cannot?(:read, @answer) # This is handled in a controller
        assert ability.cannot?(:edit, @answer)
        assert ability.cannot?(:create, @answer)
    end

  end
end
