class EmotionalSupportRequestController < ApplicationController
    # Create an emotional support request
    def post
        return error_message "Unauthorized" if cannot? :create, EmotionalSupportRequest
        # Ensure user can only have one active emotional support request at all times
        if EmotionalSupportRequest.find_by(user_id: current_user.id) == nil
            @esr = EmotionalSupportRequest.new
            @esr.user_id = current_user.id
            @esr.save!

            role = UserRole.find_by(user_id: current_user.id, role: "ROLE_PATIENT")
            therapist = UserRole.find_by(user_group_id: role.user_group_id, role: "ROLE_PROFESSIONAL")

            @not = Alert.new
            @not.active = true
            @not.description = "Patient #{current_user.name} is requesting emotional support"
            @not.high_priority = true
            @not.topic = "Emotional Support"
            @not.web_link = "https://example.com"
            @not.user_id = therapist.user_id
            @not.save!
            message 'An emotional support request has been created.'
        else
            message 'You already have an active emotional support request, please wait for your healthcare professional\'s response!'
        end
    end

    # Delete/unflag an emotional support request
    def delete
        @esr = EmotionalSupportRequest.find_by(id: params[:id])
        return error_message "Unauthorized" unless can? :delete, @esr
        @esr.destroy!
        message "Selected emotional support request has been successfully deleted."
    end

    private
        # Only allow a list of trusted parameters through.
        def esr_params
            params.permit(:id)
        end
  
  end