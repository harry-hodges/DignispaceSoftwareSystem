require 'rails_helper'
include BCrypt

RSpec.describe 'Emotional Support Request API' do
    RSpec.configure do |config|
      config.include AuthCommon
    end

    before :each do
    @groups = UserGroup.create!([
        content_released: false,
        image: "",
        name: ""
    ])
    @roles = UserRole.create!([{
        role: "ROLE_PROFESSIONAL",
        user_id: Common.admin.id,
        user_group_id: @groups[0].id
    },
    {
        role: "ROLE_PATIENT",
        user_id: Common.user.id,
        user_group_id: @groups[0].id
    }])

    end

    describe 'open a request' do
        it 'allows user to create an emotional support request' do
            tok = user_token
            post '/api/emotional_support_request', headers: {'JILLAUTH' => tok}

            # Failsafe (ensure correct API response)
            data = JSON.parse(response.body)

            assert data['Message'].include? "An emotional support request has been created."

            # Ensure users cannot create a second emotional support request when they already have one active
            post '/api/emotional_support_request', headers: {'JILLAUTH' => tok}
            data = JSON.parse(response.body)

            assert data['Message'].include? "You already have an active emotional support request, please wait for your healthcare professional\'s response!"
        end
    end

    describe 'close a request' do
        it 'allows admin to delete an emotional support request' do
            @esrs = EmotionalSupportRequest.create!([
                {
                    user_id: Common.user.id
                }])

            delete '/api/emotional_support_request/' + @esrs[0].id.to_s, headers: {'JILLAUTH' => token}
            assert EmotionalSupportRequest.find_by(id: @esrs[0].id) == nil

            # Failsafe (ensure correct API response)
            data = JSON.parse(response.body)
            assert data['Message'].include? "Selected emotional support request has been successfully deleted."
        end
    end
end
