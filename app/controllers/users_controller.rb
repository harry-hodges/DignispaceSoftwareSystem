class UsersController < ApplicationController
    include BCrypt

    def getCollection
        return error_message "Unauthorized" if cannot? :index, User
        render :json => User.all
    end

    def post
        return error_message "Unauthorized" if cannot? :create, User

        @user = User.new
        @user.role = params[:role]
        @user.name = params[:name]
        @user.email = params[:email]
        @user.save!

        message "User created"
    end

    def put
        @user = User.find_by(id: params[:id])
        return error_message "Unauthorized" if cannot? :edit, @user

        if current_user.admin?
            @user.role = params[:role] if params[:role].present?
            @user.email = params[:email] if params[:email].present?
            
            @user.suspended = params[:suspended] if params[:suspended] != nil
        end

        if current_user.id == @user.id
            @user.hhash = Password.create(params[:password]) if params[:password].present?
        end

        @user.name = params[:name] if params[:name].present?
        @user.save!

        message "User edited"
    end
  
end
  