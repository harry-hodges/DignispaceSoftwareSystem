class FlagController < ApplicationController

    # Get list of all flags (admin)
    def getCollection
        return error_message "Unauthorized" unless can? :list, Flag
        render :json => Flag.where(active: true)
    end

    # Flag an answer (admin)
    def post
      return error_message "Unauthorized" unless can? :create, Flag
  
      @flag = Flag.new(flag_params)
      @flag.save!
      message 'This answer has been successfully flagged.'
    end
    
    # Update the status or leave a remark on an existing flag (admin)
    def put
      @flag = Flag.find(params[:id])
      return error_message "Unauthorized" unless can? :update, @flag
  
      @flag.update(flag_params)
      message 'The flag for this answer has been successfully updated.'
    end

    # Delete a flag in cases where an answer is incorrectly or accidentally flagged (admin)
    def delete
      @flag = Flag.find(params[:id])
      return error_message "Unauthorized" if cannot? :delete, @flag

      @flag.destroy!
      message 'The flag for this answer has been successfully deleted.'
    end

    private
    # Only allow a list of trusted parameters through.
      def flag_params
          params.permit(:id, :answer_id, :active, :reason, :remarks)
      end
  
  end
  