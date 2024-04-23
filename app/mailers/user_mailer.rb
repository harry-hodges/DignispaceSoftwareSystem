class UserMailer < ApplicationMailer
    def confirm_email
        @user = params[:user]
        @text = params[:text]
        @link = params[:link]
        @title = params[:title]
        # TODO: GET FROM ENV
        @url  = "http://127.0.0.1:3000/ben_do_this_please?post_login=#{@link}&key="
        mail(to: @user.email, subject: 'Dignity Therapy Notification')
    end
end
