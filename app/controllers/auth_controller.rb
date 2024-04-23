class AuthController < ApplicationController
    include BCrypt
    def getCollection
        if (current_user != nil)
            user_data = current_user.as_json.merge({ profile_image: current_user.profile_image })
            render :json => user_data
        else
            error_message "Not logged in"
        end
    end

    def post
        @user = User.find_by(email: params[:email].downcase)
        return message "Email/Password not valid" if @user == nil

        return message "Your account is suspended" if !@user.valid

        if (@user.hhash != nil && Password.new(@user.hhash) == params[:password])
            token = @user.add_token
            return message "Please try again" if token == nil

            render :json => {Token: token}
        else
            message "Email/Password not valid"
        end      
    end

    def delete
        if (current_user != nil)
            current_user.logout
            message "Logged out"
        else
            error_message "No user to logout"
        end
    end
  end