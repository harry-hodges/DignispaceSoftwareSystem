# == Schema Information
#
# Table name: flags
#
#  id         :bigint           not null, primary key
#  active     :boolean
#  reason     :string
#  remarks    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  answer_id  :bigint
#
# Indexes
#
#  index_flags_on_answer_id  (answer_id)
#
# Foreign Keys
#
#  fk_rails_...  (answer_id => answers.id)
#
require 'rails_helper'

RSpec.describe Flag, type: :model do
  before :each do
    @user_group = UserGroup.create!(content_released: true, image: "image", name: "name")
    @question = Question.create!(contents: "Question contents", sensitivity: "Question sensitivity", title: "Question title")
    @answer = Answer.create!(contents: "Answer contents", question_id: @question.id, user_group_id: @user_group.id)
    @flag = Flag.create!(answer: @answer, active: true, reason: "Test Reason")

    @current_user = User.create!(email: "user@example.com", name: "Normal User", role: "ROLE_USER")
    @healthcare_professional = User.create!(email: "professional@example.com", name: "Healthcare Professional", role: "ROLE_PROFESSIONAL")

    UserRole.create!(user: @healthcare_professional, user_group: @user_group, role: "ROLE_PROFESSIONAL")
  end

  describe 'security' do
    it 'disallows flag to be created or edited by a normal user' do
      ability = Ability.new(@current_user)
      # assert ability.can?(:list, @flag)
      assert ability.cannot?(:update, @flag)
      assert ability.cannot?(:create, Flag.new(answer: @answer))
      assert ability.cannot?(:delete, @flag)
    end

    it 'allows flag to be created or edited by a healthcare professional' do
      ability = Ability.new(@healthcare_professional)
      # assert ability.can?(:list, @flag)
      assert ability.can?(:edit, @flag)
      assert ability.can?(:create, Flag.new(answer: @answer))
      assert ability.can?(:delete, @flag)
    end
  end
end
