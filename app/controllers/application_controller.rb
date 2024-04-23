class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  self.allow_forgery_protection = false 
    
  def current_user
    token = request.headers["JILLAUTH"]
    User.token_or_null(token)
  end

  def message(message)
    render :json => {Message: message}
  end

  def error_message(message)
    render :json => {Message: message}, :status => :unauthorized
  end

  private
    # def update_headers_to_disable_caching
    #   response.headers['Cache-Control'] = 'no-cache, no-cache="set-cookie", no-store, private, proxy-revalidate'
    #   response.headers['Pragma'] = 'no-cache'
    #   response.headers['Expires'] = '-1'
    # end

    protected
end
