class PotentialEditsController < ApplicationController

    # get a potential edit for a question
    def get
        @potential_edit = PotentialEdit.find_by(answer_id: params[:id])
        return error_message "Unauthorized" if cannot? :read, @potential_edit
        render :json => @potential_edit
    end

    # delete a potential edit (if it has been rejected by patient)
    def delete
        @potential_edit = PotentialEdit.find_by(id: params[:id])
        return error_message "Unauthorized" if cannot? :delete, @potential_edit
        @potential_edit.destroy!


        @ale = AuditLogEntry.new
        @ale.action = "Rejected"
        @ale.details = "Potential edit rejected by patient"
        @ale.answer_id = @potential_edit.answer_id
        @ale.user_id = current_user.id
        @ale.save!

        message "Edit was rejected."
    end

    # Create a potential edit
    def post
        return error_message "Unauthorized" if cannot? :create, PotentialEdit
        @potential_edit = PotentialEdit.new(potential_edit_params)
        @potential_edit.save!

        @ale = AuditLogEntry.new
        @ale.action = "Potential Edit Created"
        @ale.details = "Potential edit created by healthcare professional"
        @ale.answer_id = @potential_edit.answer_id
        @ale.user_id = current_user.id
        @ale.save!

        user_group = Answer.find_by(id: params[:answer_id]).user_group_id
        patient = UserRole.find_by(user_group_id: user_group, role: "ROLE_PATIENT")

        @not = Alert.new
        @not.active = true
        @not.description = "Question has a new potential edit to review"
        @not.high_priority = false
        @not.topic = "Question answers"
        @not.web_link = "https://example.com"
        @not.user_id = patient.user_id
        @not.save!

        message 'A potential edit was successfully created'
    end

    # edit is accepted, it will replace the answer with the edit
    def accept_potential_edit
        @potential_edit = PotentialEdit.find_by(id: params[:id])
        return error_message "Unauthorized" if cannot? :edit, @potential_edit
        @bubble = Answer.find(@potential_edit.answer_id)
        @bubble.update(contents: @potential_edit.editContents)
        @bubble.save!
        @potential_edit.accepted = true
        @potential_edit.save!

        @ale = AuditLogEntry.new
        @ale.action = "Potential Edit accepted"
        @ale.details = "Potential edit created by patient"
        @ale.answer_id = @potential_edit.answer_id
        @ale.user_id = current_user.id
        @ale.save!

        message 'Answer contents was successfully updated'
    end

    private
        # Only allow a list of trusted parameters through.
        def potential_edit_params
            params.permit(:id, :accepted, :editContents, :answer_id)
        end


end