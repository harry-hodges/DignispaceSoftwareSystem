require 'rails_helper'
include BCrypt
require 'date'
RSpec.describe 'Alert API' do

    RSpec.configure do |config|
        config.include AuthCommon
    end

    before :each do
        @alerts = Alert.create!([
        {
            created_at: DateTime.now,
            active: 1,
            topic: "Alert topic",
            description: "Alert description",
            web_link: "https://weblink.co.uk",
            high_priority: true,
            user_id: Common.admin.id
        }])
    end

    describe 'create alert' do
        it 'appears on the list of alerts' do
            get '/api/alerts', headers: {'JILLAUTH' => token}
            data = JSON.parse(response.body)
            # alert topic is the topic that was previously created
            assert @alerts[0].topic == data[0]['topic']
        end
    end

    describe 'edit an alert' do
        it 'changes an existing alert' do
            
            put "/api/alerts/#{@alerts[0].id.to_s}", params:
            {
                topic: "edited topic"
            }, headers: {'JILLAUTH' => token}
            @alerts[0].reload
            
            # alert topic has been edited
            assert @alerts[0].topic == "edited topic"
        end
    end
end