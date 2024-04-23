class RolesController < ApplicationController

  def getCollection
    render :json => UserRole.where(user_id: current_user.id), include: :get_group
  end

  def post
    @role = UserRole.new
    @role.user_group_id = params[:user_group_id]
    
    return error_message "Unauthorized" if cannot? :create, @role

    @user = User.find_by(email:params[:email] )

    if @user == nil
      @user = User.new
      @user.email = params[:email]
      @user.role = "ROLE_USER"
      @user.name = params[:name]
      @user.created_at = DateTime.now
      @user.updated_at = DateTime.now
      @user.save!

      User.send_confirm_email(@user, "You have been invited to view a patients messages", "/groups/#{params[:user_group_id]}")
    end

    
    @role.user_id = @user.id
     
    @role.role = "ROLE_VIEWER"
    @role.save!
    render :json => @role
  end

  def delete
    @role = UserRole.find_by(id: params[:id])
    
    return error_message "Unauthorized" if cannot? :delete, @role

    @role.destroy!

    message "User removed"
  end

end

