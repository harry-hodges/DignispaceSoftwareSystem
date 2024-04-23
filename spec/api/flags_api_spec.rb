require 'rails_helper'
include BCrypt

RSpec.describe 'Flags API' do
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
        @flags = Flag.create!([
        {
            active: 1,
            reason: "Harmful language",
            answer_id: @answers[0].id
        }])
    end

    describe 'create flag' do
        it 'appears on the list of flags' do

            # flag contents is the contents that was previously created
            assert @flags[0].reason = "Harmful language"
        end
    end

    describe 'edit an flag' do
        it 'changes an existing flag' do

            Common.admin()
            
            put '/api/flag/' + @flags[0].id.to_s, params:
            {
                reason: "edited reason"
            }, headers: {'JILLAUTH' => token}

            getted_data = JSON.parse(response.body)

            # flag contents is the contents that was previously created
            assert getted_data['reason'] = "edited reason"
        end
    end
end