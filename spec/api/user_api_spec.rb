require 'rails_helper'
include BCrypt
require 'date'
RSpec.describe 'User API' do

    RSpec.configure do |config|
        config.include AuthCommon
    end

    before :each do
        @users = User.create!([
            "name": "Pofessional",
            "email": "prof1@shef.ac.uk",
            "role": "ROLE_USER", 
            "suspended": true,
            "token": "TEMP"
        ])
    end

    describe 'create user' do
        it 'appears on the list of users' do
            post '/api/users', headers: {'JILLAUTH' => token}, params: {
                "role": "ROLE_ADMIN",
                "name": "qwe2 ewq",
                "email": "testing_new@qwe.qwe"
            }
            get '/api/users', headers: {'JILLAUTH' => token}
            data = JSON.parse(response.body)
            # alert topic is the topic that was previously created
            assert response.body.to_s.include?("testing_new@qwe.qwe")
        end
    end

    describe 'edit a user (admin)' do
        it 'changes an existing user' do
            
            put "/api/users/#{@users[0].id.to_s}", params:
            {
                "name": "Pofessional2",
                "email": "prof2@shef.ac.uk",
                "role": "ROLE_ADMIN", 
                "suspended": false,
            }, headers: {'JILLAUTH' => token}
            @users[0].reload
            
            assert @users[0].name == "Pofessional2"
            assert @users[0].email == "prof2@shef.ac.uk"
            assert @users[0].role == "ROLE_ADMIN"
            assert @users[0].suspended == false
        end
    end

    describe 'edit a user (user)' do
        it 'changes an existing user' do
            put "/api/users/#{@users[0].id.to_s}", params:
            {
                "name": "Pofessional2",
                "email": "prof2@shef.ac.uk",
                "role": "ROLE_ADMIN", 
                "suspended": false,
                "password": "qweqwe"
            }, headers: {'JILLAUTH' => "TEMP"}
            @users[0].reload
            
            assert @users[0].name == "Pofessional2"
            assert @users[0].email == "prof1@shef.ac.uk"
            assert @users[0].role == "ROLE_USER"
            assert @users[0].suspended == true
            assert Password.new(@users[0].hhash) == "qweqwe"
        end
    end
end