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
require 'rails_helper'
RSpec.describe Alert, type: :model do

  before :each do
    @current_user = User.create!(email: "user@example.com", name: "Normal User", role: "ROLE_USER", id: 1)
    @admin_user = User.create!(email: "admin@example.com", name: "Admin User", role: "ROLE_ADMIN", id: 2)

    @alerts = Alert.create!([
    {
        created_at: DateTime.now,
        active: 1,
        topic: "Alert topic",
        description: "Alert description",
        web_link: "https://weblink.co.uk",
        high_priority: true,
        user_id: 2
    }])
  end

  describe 'security' do

    it 'disallows normal user to push alerts' do
        ability = Ability.new(@current_user)
        assert ability.cannot?(:update, @alerts)
    end

    it 'allows admins to push alerts' do
      ability = Ability.new(@admin_user)
      assert ability.can?(:update, @alerts)
    end

  end
end
