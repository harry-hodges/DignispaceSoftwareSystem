class GroupsController < ApplicationController

    def get
        @group = UserGroup.find(params[:id])
        return error_message "Unauthorized" if cannot? :read, @group
        render :json => @group
    end

    def post
        return error_message "Unauthorized" if cannot? :create, @group

        # CREATE GROUP
        @group = UserGroup.new
        @group.name = params[:name]
        @group.image = PhotoBackend.fetch_random_photo
        @group.save!


        # ADD USER
        @patient = User.find_by(email: params[:patient_email])

        if @patient == nil
            @patient = User.new
            @patient.email = params[:patient_email]
            @patient.role = "ROLE_USER"
            @patient.name = params[:name]
            @patient.created_at = DateTime.now
            @patient.updated_at = DateTime.now
            @patient.save!
            
            User.send_confirm_email(@patient, "You have been invited to partake in dignity therapy, please login to validate your account", "/groups/#{@group.id}")
        end


        @role = UserRole.new
        @role.user_group_id = @group.id
        @role.user_id = @patient.id
         
        @role.role = "ROLE_PATIENT"
        @role.save!

        # ADD HEALTHCARE PROFESSIONAL
        @role = UserRole.new
        @role.user_group_id = @group.id
        @role.user_id = current_user.id
         
        @role.role = "ROLE_PROFESSIONAL"
        @role.save!  

        render :json => @group
    end

    def put
        @group = UserGroup.find_by(id: params[:id])

        return error_message "Unauthorized" if cannot? :edit, @group

        @group.content_released = true
        @group.save!

        for role in UserRole.where(user_group_id: @group.id, role: "ROLE_VIEWER")
            @not = Alert.new
            @not.active = true
            @not.description = "Patient answers are available to view"
            @not.high_priority = true
            @not.topic = "Patient answers"
            @not.web_link = "https://example.com"
            @not.user_id = role.user_id
            @not.save!
        end
    end
  
end
  
  