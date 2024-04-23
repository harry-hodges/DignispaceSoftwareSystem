require 'rails_helper'
include BCrypt

RSpec.describe 'Question API' do
    RSpec.configure do |config|
        config.include AuthCommon
    end
    before :each do
        @questions = Question.create!([
        {
            contents: "Question contents",
            sensitivity: "Question sensitivity",
            title: "Question title"
        }])
    end

    # *** doesnt test any more lines of code ***
    # describe 'get all questions' do
    #     it 'checks the questions can be obtained' do
    #         Common.admin()

    #         get '/api/questions', headers: {'JILLAUTH' => token}
    #         getted_data = JSON.parse(response.body)
    #         pp getted_data
    #         assert getted_data.length != 0
    #     end
    # end

    describe 'create question' do
        it 'appears on the list of questions' do
            Common.admin()

            post '/api/questions', params:
            {
                contents: "Question contents",
                sensitivity: "Question sensitivity",
                title: "Question title"
            }

            get '/api/questions', headers: {'JILLAUTH' => token}
            data = JSON.parse(response.body)
            # question contents is the contents that was previously created
            assert @questions[0].contents == data[0]['contents']
        end
    end

    describe 'delete question' do
        it 'removes question from the list of questions' do
            Common.admin

            delete "/api/questions/#{@questions[0].id.to_s}", headers: {'JILLAUTH' => token}
            assert Question.find_by(id: @questions[0].id) == nil
        end
    end
end