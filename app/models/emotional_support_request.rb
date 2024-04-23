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
class EmotionalSupportRequest < ApplicationRecord
    belongs_to :user
  
    # Validates that a user_id is present and that there's only one active request per user
    validates :user_id, presence: true
    validate :only_one_active_request_per_user
  
    private
  
    def only_one_active_request_per_user
      if new_record? && EmotionalSupportRequest.where(user_id: user_id).exists?
        errors.add(:user_id, 'already has an active emotional support request')
      end
    end
  end
  
