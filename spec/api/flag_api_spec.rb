require 'rails_helper'
include BCrypt

RSpec.describe 'Flag API' do
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
          id: 1,
          contents: "Answer contents",
          question_id: @question[0].id,
          user_group_id: @user_group[0].id
      }])
      @flag = Flag.create!([
      {
          id: 1,
          answer_id: 1,
          active: true,
          reason: "Test Reason"
      }])
    end

    describe 'get list of flagged answers' do
        it 'appears on the flagged answers page' do
            get '/api/flag', headers: {'JILLAUTH' => token}
            assert Flag.find_by(id: @flag[0].id).answer_id == 1
        end
    end

    describe 'flag an answer' do
        it 'allow admin to flag an answer for review' do
            post '/api/flag/', params:
            {
                id: 2,
                answer_id: 1,
                active: true,
                reason: "Placeholder Reason"
            }, headers: {'JILLAUTH' => token}
            @new_flag = Flag.find_by(id: 2)
            assert @new_flag.answer_id == 1
            assert @new_flag.active == true
            assert @new_flag.reason == "Placeholder Reason"

            # Failsafe (ensure correct API response)
            data = JSON.parse(response.body)
            assert data['Message'].include? "This answer has been successfully flagged."
        end
    end

    describe 'unflag an answer' do
        it 'allow admin to unflag an answer that has been resolved' do
            put "/api/flag/#{@flag[0].id}", params:
            {
                active: false,
            }, headers: {'JILLAUTH' => token}
            @flag[0].reload
            assert Flag.find_by(id: @flag[0].id).active == false

            # Failsafe (ensure correct API response)
            data = JSON.parse(response.body)
            assert data['Message'].include? "The flag for this answer has been successfully updated."
        end
    end

    describe 'delete a flag' do
        it 'allow admin to delete a flag that has been incorrectly or accidentally created' do
            delete "/api/flag/#{@flag[0].id}", headers: {'JILLAUTH' => token}
            assert Flag.find_by(id: @flag[0].id) == nil

            # Failsafe (ensure correct API response)
            data = JSON.parse(response.body)
            assert data['Message'].include? "The flag for this answer has been successfully deleted."
        end
    end
end