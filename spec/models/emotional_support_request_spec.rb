# == Schema Information
#
# Table name: emotional_support_requests
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_emotional_support_requests_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe EmotionalSupportRequest, type: :model do
  before :each do
    @current_user = User.create!(email: "user@example.com", name: "Normal User", role: "ROLE_PATIENT", id: 1)
    @healthcare_professional = User.create!(email: "admin@example.com", name: "Admin User", role: "ROLE_PROFESSIONAL", id: 2)  
    @esrs = EmotionalSupportRequest.create!([
    {
        user_id: 1
    }])

  end

  describe 'Associations' do
    it 'belongs to a user' do
      esr = EmotionalSupportRequest.new(user_id: @current_user.id)
      expect(esr.user).to eq(@current_user)
    end
  end

  describe 'Validations' do
    it 'is not valid without a user_id' do
      esr = EmotionalSupportRequest.new
      expect(esr).not_to be_valid
      expect(esr.errors[:user]).to include("must exist")
    end
  end

  describe 'Custom Methods' do
    context 'when creating multiple requests' do
      it 'does not allow a second active request for the same user' do
        EmotionalSupportRequest.new(user: @current_user)

        second_request = EmotionalSupportRequest.new(user: @current_user)

        expect(second_request.valid?).to be false
        expect(second_request.errors[:user_id]).to include('already has an active emotional support request')
      end     
    end
  end

  describe 'security' do
    it 'allows patient to create an emotional support request but not delete' do
      ability = Ability.new(@current_user)
      assert ability.can?(:create, EmotionalSupportRequest)
      assert ability.cannot?(:delete, @esrs[0])
    end

    it 'allows admin to delete an emotional support request' do
      ability = Ability.new(@healthcare_professional)
      assert ability.can?(:create, EmotionalSupportRequest)
      assert ability.can?(:delete, @esrs[0])    
    end
  end

end
