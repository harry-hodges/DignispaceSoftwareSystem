class QuestionsController < ApplicationController

    # return a list of all question
    def getCollection
        return error_message "Unauthorized" if cannot? :read, Question
        render :json => Question.all
    end

    # delete a question
    def delete
        return error_message "Unauthorized" if cannot? :delete, Question
        @question = Question.find_by(id: params[:id])
        @question.destroy!
        message "Question was successfully deleted."
    end

    # create a question
    def post
        @question = Question.new(question_params)
        @question.save!
        message 'Question was created.'
    end

    private
        # Only allow a list of trusted parameters through.
        def question_params
            params.permit(:contents, :number, :sensitivity, :title)
        end
end