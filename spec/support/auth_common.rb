require 'rspec/rails'

module AuthCommon
    def token
      post '/api/auth', params: {
        email: Common.admin.email,
        password: "qwe" 
      }

      data = JSON.parse(response.body)
      return data['Token']
  end
  def user_token
    post '/api/auth', params: {
      email: Common.user.email,
      password: "qwe" 
    }

    data = JSON.parse(response.body)
    return data['Token']
end
end