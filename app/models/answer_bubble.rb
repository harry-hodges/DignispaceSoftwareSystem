# == Schema Information
#
# Table name: answer_bubbles
#
#  id        :bigint           not null, primary key
#  answer_id :bigint
#  bubble_id :bigint
#
# Indexes
#
#  index_answer_bubbles_on_answer_id  (answer_id)
#  index_answer_bubbles_on_bubble_id  (bubble_id)
#
# Foreign Keys
#
#  fk_rails_...  (answer_id => answers.id)
#  fk_rails_...  (bubble_id => bubbles.id)
#
class AnswerBubble < ApplicationRecord
end
