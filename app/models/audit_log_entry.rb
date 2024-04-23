# == Schema Information
#
# Table name: audit_log_entries
#
#  id         :bigint           not null, primary key
#  action     :string
#  details    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  answer_id  :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_audit_log_entries_on_answer_id  (answer_id)
#  index_audit_log_entries_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (answer_id => answers.id)
#  fk_rails_...  (user_id => users.id)
#
class AuditLogEntry < ApplicationRecord
    belongs_to :answer
    belongs_to :user 
end
