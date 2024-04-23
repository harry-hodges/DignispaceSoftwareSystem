require 'rails_helper'
include BCrypt

RSpec.describe 'Answer API' do
    RSpec.configure do |config|
        config.include AuthCommon
    end
    before :each do
        @user_group = UserGroup.create!([
        {
            content_released: true,
            image: "image",
            name: "name"
        }])
        @question = Question.create!([
        {
            contents: "Question contents",
            sensitivity: "Question sensitivity",
            title: "Question title"
        }])
        @answers = Answer.create!([
        {
            contents: "Answer contents",
            question_id: @question[0].id,
            user_group_id: @user_group[0].id
        }])
        @bubble = Bubble.create!(name: "Test Bubble", user_group_id: @user_group[0].id)

        @users = User.create!([
            "name": "Pofessional",
            "email": "prof1@shef.ac.uk",
            "role": "ROLE_USER", 
            "suspended": true,
            "token": "TEMP"
        ])
        UserBubble.create!(user_id: @users[0].id, bubble_id: @bubble.id)

        @patient = User.create!(email: "patient@example.com", name: "Patient Test", role: "ROLE_USER")
        UserRole.create!(user_group_id: @user_group[0].id, user_id: @patient.id, role: "ROLE_PATIENT")
        UserRole.create!(user_group_id: @user_group[0].id, user_id: @users[0].id, role: "ROLE_VIEWER")
    end

    describe 'create answer' do
        it 'appears on the list of answers' do
            post '/api/answer', params: 
            {
                question_id: @question[0].id,
                user_group_id: @user_group[0].id

            }, headers: {'JILLAUTH' => token}

            get "/api/answer/#{@answers[0].id}", headers: {'JILLAUTH' => token}
            data = JSON.parse(response.body)
            
            # answer contents is the contents that was previously created
            assert data[1]["contents"] == ""
        end
    end

    describe 'edit an answer' do
        it 'changes an existing answer' do

            Common.admin()
            post '/api/answer', params: 
            {
                question_id: @question[0].id,
                user_group_id: @user_group[0].id

            }, headers: {'JILLAUTH' => token}
            put "/api/answer/#{@answers[0].id}", params:
            {
                contents: "edited contents",
                bubbles: []
            }, headers: {'JILLAUTH' => token}

            response_data = JSON.parse(response.body)

            # answer contents is the contents that was previously created
            assert response_data['contents'] = "edited contents"
        end
    end

    describe 'view some as viewer' do
        it 'works' do

            Common.admin()
            post '/api/answer', params: 
            {
                question_id: @question[0].id,
                user_group_id: @user_group[0].id

            }, headers: {'JILLAUTH' => token}
            put "/api/answer/#{@answers[0].id}", params:
            {
                contents: "edited contents",
                bubbles: [@bubble.id]
            }, headers: {'JILLAUTH' => token}


            get "/api/answer/#{@user_group[0].id}", headers: {'JILLAUTH' => "TEMP"}
            response_data = JSON.parse(response.body)
            # pp response_data
            assert response_data.length == 1
            assert response.body.to_s.include?("edited contents")
        end
    end
end