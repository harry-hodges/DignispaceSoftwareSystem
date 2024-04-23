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
class Flag < ApplicationRecord
    belongs_to :answer
    delegate :user_group, to: :answer, allow_nil: true
end
