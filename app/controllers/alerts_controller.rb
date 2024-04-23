class AlertsController < ApplicationController

    def getCollection
      render :json => Alert.where(user_id: current_user.id)
    end
  
    def put
      @alert = Alert.find(params[:id])
      return error_message "Unauthorized" if cannot? :update, @alert
      @alert.update(alert_params)
      @alert.save
      message "Alert successfully updated."
    end

    private
    # Only allow a list of trusted parameters through.
    def alert_params
        params.permit(:id, :active, :topic, :description, :web_link, :high_priority, :user_id)
    end
  end