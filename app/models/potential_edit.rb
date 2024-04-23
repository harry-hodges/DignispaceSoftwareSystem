# == Schema Information
#
# Table name: potential_edits
#
#  id           :bigint           not null, primary key
#  accepted     :boolean
#  editContents :string
#  answer_id    :bigint
#
# Indexes
#
#  index_potential_edits_on_answer_id  (answer_id)
#
# Foreign Keys
#
#  fk_rails_...  (answer_id => answers.id)
#
class PotentialEdit < ApplicationRecord
    belongs_to :answer
end
