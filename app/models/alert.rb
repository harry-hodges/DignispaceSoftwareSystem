# == Schema Information
#
# Table name: alerts
#
#  id            :bigint           not null, primary key
#  active        :integer
#  description   :string
#  high_priority :boolean
#  topic         :string
#  web_link      :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :bigint
#
# Indexes
#
#  index_alerts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Alert < ApplicationRecord
    belongs_to :user

    def sendd
        User.send_confirm_email(user, self.topic, self.description, self.web_link)
    end

    after_save :sendd
end
