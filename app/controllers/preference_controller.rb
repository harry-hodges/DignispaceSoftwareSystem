class PreferenceController < ApplicationController

    # Get the list of existing preferences
    def getCollection
        render :json => Preference.where(user_id: current_user.id)
    end

    # Update user preference
    def put
        @preference = Preference.find_by(id: params[:id])
        return error_message "Unauthorized" if cannot? :update, @preference
        @preference.update(preference_params)
        @preference.save!
        message "Preference was successfully updated."
    end

    # Create a preference (admin)
    def post
        @preference = Preference.new(preference_params)
        return error_message "Unauthorized" if cannot? :create, @preference
        @preference.user_id = current_user.id
        @preference.save!
        message 'Preference was created.'
    end

    # Delete a preference (admin)
    def delete
        @preference = Preference.find_by(id: params[:id])
        return error_message "Unauthorized" if cannot? :delete, @preference
        @preference.destroy!
        message 'Preference was deleted.'
    end
    
    private
        # Only allow a list of trusted parameters through.
        def preference_params
            params.permit(:id, :name, :value)
        end
end