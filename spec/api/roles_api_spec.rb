require 'rails_helper'
include BCrypt

RSpec.describe 'Roles API' do
    RSpec.configure do |config|
        config.include AuthCommon
    end
    before :each do
        @users = User.create!([
        {
          name: "Admin Adminson",
          email: "admin2@shef.ac.uk",
          hhash: Password.create("qwe"),
          role: "ROLE_ADMIN"
        }])
        @user_groups = UserGroup.create!([
        {
            content_released: true,
            image: "image",
            name: "name"
        }])
        @roles = UserRole.create!([
        {
            role: "ROLE_VIEWER",
            user_group_id: @user_groups[0].id,
            user_id: @users[0].id
        }])
    end

    describe 'add a viewer to a user group' do
        it 'appears on the viewers of that user group' do
            Common.admin
            post '/api/roles', params:
            {
                email: "admin_for_can_testing@shef.ac.uk",
                user_group_id: @user_groups[0].id
            }, headers: {'JILLAUTH' => token}

            get '/api/roles', headers: {'JILLAUTH' => token}
            response_data = JSON.parse(response.body)

            assert "ROLE_VIEWER" == response_data[0]['role']
        end
    end

    describe 'add a role to a new user' do
        it 'applies the ROLE_USER role to the user' do
            post '/api/roles', params:
            {
                email: "newuser@email.com",
                name: "Bill Billson",
                user_group_id: @user_groups[0].id
            }, headers: {'JILLAUTH' => token}

            email = ActionMailer::Base.deliveries.first

            index = email.body.to_s.index("key=")
            # pp index

            ten_characters_after_key = email.body.to_s[index + 4, 22]
            # pp(ten_characters_after_key)

            get '/api/confirmation', params: {
                token: ten_characters_after_key
            }

            data = JSON.parse(response.body)

            get '/api/roles', headers: {'JILLAUTH' => data['Token']}
            response_data = JSON.parse(response.body)

            assert response_data[0]['role'] == "ROLE_VIEWER"
        end
    end

    describe 'remove a viewer from a user group' do
        it 'removes the viewer from the viewers of that group' do
            Common.admin

            delete "/api/roles/#{@roles[0].id}", headers: {'JILLAUTH' => token}
            assert UserRole.find_by(id: @roles[0].id) == nil
        end
    end
end