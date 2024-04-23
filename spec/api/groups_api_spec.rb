require 'rails_helper'
include BCrypt

RSpec.describe 'Groups API' do
    RSpec.configure do |config|
      config.include AuthCommon
    end

    before :each do
      @user_groups = UserGroup.create!([
      {
          content_released: true,
          image: "image",
          name: "name"
      }])

      UserRole.create!(user_id: Common.user.id, user_group_id: @user_groups[0].id, role: "ROLE_VIEWER")
    end 
    
    describe 'create a user group' do
        it 'appears on the list of user groups' do
            post '/api/groups', params: 
            {
                patient_email: "patient1@example.com",
                name: "name"
            }, headers: {'JILLAUTH' => token}

            get "/api/groups/#{@user_groups[0].id}", headers: {'JILLAUTH' => token}
            data = JSON.parse(response.body)
            # group name is the name that was previously created
            assert @user_groups[0].name == data['name']
            email = ActionMailer::Base.deliveries[0] != nil
        end
    end

    describe 'edit a user group' do
        it 'appears on the list of user groups' do
            put "/api/groups/#{@user_groups[0].id}", params: 
            {
                content_released: true
            }, headers: {'JILLAUTH' => token}

            
            email = ActionMailer::Base.deliveries[0] != nil
        end
    end
end