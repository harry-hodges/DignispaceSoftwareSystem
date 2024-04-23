class ConfirmationController < ApplicationController

    def post
        @user = User.find_by(email: params[:email])
        User.send_confirm_email(@user)
       
    
        render :json => {Message: "Login Email Sent"}
    end

    def getCollection
        # USEAGE:
        # redirect to a page on the frontend with a email confirm code in url params
        # send get here with code in body content
        @user = User.email_or_null( params[:token])

        return message "Pending confirmation not found" if @user == nil

        token = @user.add_token

        return message "Please try again" if token == nil

        @user.remove_email_token
        
        return message "Please try again" if !@user.save

        render :json => {Token: token}
      end
  end