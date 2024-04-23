require 'rails_helper'
include BCrypt

RSpec.describe 'Potential Edits API' do
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
        @potential_edits = PotentialEdit.create!([
        {
            accepted: false,
            editContents: "Edit contents",
            answer_id: @answers[0].id
        }])
        UserRole.create!(user_group_id: @user_group[0].id, user_id: Common.user.id, role: "ROLE_PATIENT")
    end


    describe 'create an edit' do
        it 'gets an edit by answer id' do
            Common.admin()

            post '/api/potential_edits', params:
            {
                editContents: "Edit contents",
                answer_id: @answers[0].id
            }, headers: {'JILLAUTH' => token}

            get "/api/potential_edits/#{@answers[0].id}", headers: {'JILLAUTH' => token}
            getted_data = JSON.parse(response.body)

            # edit contents is the contents that was previously created
            assert @potential_edits[0].editContents == getted_data['editContents']
        end
    end

    describe 'accept an edit' do
        it 'replaces the answer_id with the edit contents' do
            post "/api/potential_edits/accept/#{@potential_edits[0].id.to_s}", headers: {'JILLAUTH' => token}
            data = JSON.parse(response.body)
            assert data['Message'].include? "Answer contents was successfully updated"
        end
    end

    describe 'Reject an edit' do
        it 'Deletes an edit if it is not approved' do
            Common.admin

            delete '/api/potential_edits/' + @potential_edits[0].id.to_s, headers: {'JILLAUTH' => token}
            assert PotentialEdit.find_by(id: @potential_edits[0].id) == nil
        end
    end
end
