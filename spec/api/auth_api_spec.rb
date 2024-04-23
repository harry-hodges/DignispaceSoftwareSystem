require 'rails_helper'
include BCrypt

RSpec.configure do |config|
  config.include AuthCommon
end


RSpec.describe 'User API' do
  extend AuthCommon
  before :each do
    @users = User.create!([
        {
          name: "Admin Adminson",
          email: "admin@shef.ac.uk",
          hhash: Password.create("qwe"),
          role: "ROLE_ADMIN"
        }])
  end
  describe 'login endpoint' do
    it 'allows a valid token to be generated' do

        post '/api/auth', params:
        {
          email: "admin@shef.ac.uk",
          password: "qwe" 
        }

        data = JSON.parse(response.body)

        assert data['Token'] != nil

        assert User.find_by(token: data["Token"]) != nil
    end

    it 'allows current user information to be retreived' do
      post '/api/auth', params:
      {
        email: "admin@shef.ac.uk",
        password: "qwe" 
      }

      data = JSON.parse(response.body)

      get '/api/auth/', headers: {'JILLAUTH' => data['Token']}

      data = JSON.parse(response.body)

      assert @users[0].name == data['name']
    end

    
    it 'allows helper class to work' do
      get '/api/auth/', headers: {'JILLAUTH' => token}

      data = JSON.parse(response.body)

      assert @users[0].name == data['name']
    end

    it 'allows a user to logout' do
      post '/api/auth', params:
      {
        email: "admin@shef.ac.uk",
        password: "qwe" 
      }

      data = JSON.parse(response.body)
      token = data['Token']

      # Check login was successful
      get '/api/auth/', headers: {'JILLAUTH' => token}

      data = JSON.parse(response.body)

      assert @users[0].name == data['name']

      # Actually log out
      delete '/api/auth/', headers: {'JILLAUTH' => token}

      # Check now fails
      get '/api/auth/', headers: {'JILLAUTH' => token}

      data = JSON.parse(response.body)

      assert data['message'] = "Not logged in"
    end

    it 'allows a confirmation email request to be sent' do
      # Ask for a forgot password email
      post '/api/confirmation', params:
      {
        email: "admin@shef.ac.uk",
      }
      # Get the email
      email = ActionMailer::Base.deliveries.first
      expect(email.body).to include(User.find_by(email: "admin@shef.ac.uk").email_token)
      expect(email.to).to eq(['admin@shef.ac.uk'])
    end

    it 'allows a confirmation email to be confirmed' do
      post '/api/confirmation', params:
      {
        email: "admin@shef.ac.uk",
      }

      email_token = User.find_by(email: "admin@shef.ac.uk").email_token

      get '/api/confirmation', params:
      {
        token: email_token,
      }

      data = JSON.parse(response.body)
      
      # Check it's returned a token that signs in a user
      assert data["Token"] != nil
      assert User.find_by(token: data["Token"]) != nil
    end

    it 'allows a confirmation email to be confirmed via an email' do
      # TODO
      post '/api/confirmation', params:
      {
        email: "admin@shef.ac.uk",
      }

      email = ActionMailer::Base.deliveries.first

      index = email.body.to_s.index("key=")


      ten_characters_after_key = email.body.to_s[index + 4, 22]


      get '/api/confirmation', params: {
          token: ten_characters_after_key
      }

      data = JSON.parse(response.body)

      get '/api/auth', headers: {'JILLAUTH' => data['Token']}
      response_data = JSON.parse(response.body)

      assert response_data['email'] == "admin@shef.ac.uk"
    end

    
  end
end
