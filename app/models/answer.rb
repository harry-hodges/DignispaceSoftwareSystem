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
class Answer < ApplicationRecord
    belongs_to :user_group
    has_many :potential_edit

    def get_question
        Question.find_by(id: question_id)
    end

    def audit_logs
        AuditLogEntry.where(answer_id: id)
    end

    def flags
        Flag.where(answer_id: id)
    end

    def bubbles
        AnswerBubble.where(answer_id: self.id).map {|x| Bubble.find_by(id: x.bubble_id)}
    end

    def allowed_bubbles (val)
         AnswerBubble.where(answer_id: self.id).each {|x| x.destroy}
        val.each {|x| AnswerBubble.create!([{answer_id: self.id, bubble_id: x}])}
    end
end
