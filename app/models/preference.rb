# == Schema Information
#
# Table name: preferences
#
#  id      :bigint           not null, primary key
#  name    :string
#  value   :string
#  user_id :bigint
#
# Indexes
#
#  index_preferences_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Preference < ApplicationRecord
  belongs_to :user
end
