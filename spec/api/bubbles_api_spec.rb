require 'rails_helper'
include BCrypt

RSpec.describe 'Bubbles API' do
    RSpec.configure do |config|
        config.include AuthCommon
    end
    before :each do
        @user_groups = UserGroup.create!([
        {
            content_released: true,
            image: "image",
            name: "name"
        },{        
            content_released: true,
            image: "image2",
            name: "name2"
        }])
        # @users = User.create!([
        # {
        #   name: "Admin Adminson",
        #   email: "admin@shef.ac.uk",
        #   hhash: Password.create("qwe"),
        #   role: "ROLE_ADMIN"
        # }])
        @bubbles = Bubble.create!([
        {
            name: "bubble name",
            user_group_id: @user_groups[0].id
        }])
        # @user_bubbles = UserBubble.create!([
        # {
        #     bubble_id: @bubbles[0].id,
        #     user_id: @users[0].id
        # }])
    end

    describe 'create bubble' do
        it 'appears on the list of bubbles' do
            post '/api/bubble', params: 
            {
                name: "bubble name",
                user_group_id: @user_groups[0].id,
                users: []
            }, headers: {'JILLAUTH' => token}


            get "/api/bubble/#{@user_groups[0].id}", headers: {'JILLAUTH' => token}
            data = JSON.parse(response.body)
            # bubble name is the name that was previously created
            assert @bubbles[0].name == data[0]['name']
        end
    end

    describe 'edit a bubble' do
        it 'changes an existing bubble name' do

            Common.admin()
            
            put "/api/bubble/#{@bubbles[0].id.to_s}", params:
            {
                name: "bubble name",
                users: []
            }, headers: {'JILLAUTH' => token}

            getted_data = JSON.parse(response.body)

            # bubble name is the new edited name
            assert getted_data['name'] = "bubble name"
        end

        it 'changes a bubbles users' do
            Common.admin()
            
            put "/api/bubble/#{@bubbles[0].id.to_s}", params:
            {
                users: [Common.user().id.to_s]
            }, headers: {'JILLAUTH' => token}

            get "/api/bubble/#{@user_groups[0].id.to_s}", headers: {'JILLAUTH' => token}


            getted_data = JSON.parse(response.body)
            # bubbles user group users are correcrt
            assert getted_data[0]['all_users'].length == 1

        end
    end
end