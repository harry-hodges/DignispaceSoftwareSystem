# == Schema Information
#
# Table name: user_bubbles
#
#  id        :bigint           not null, primary key
#  bubble_id :bigint
#  user_id   :bigint
#
# Indexes
#
#  index_user_bubbles_on_bubble_id  (bubble_id)
#  index_user_bubbles_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (bubble_id => bubbles.id)
#  fk_rails_...  (user_id => users.id)
#
class UserBubble < ApplicationRecord
end
