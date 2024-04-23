require 'rails_helper'

class Common
    @@user = nil
    @@admin = nil


    def self.admin
        begin
            @@admin = User.create!([
        {
            name: "Admin Adminson",
            email: "admin_for_can_testing@shef.ac.uk",
            hhash: Password.create("qwe"),
            role: "ROLE_ADMIN"
        }])[0]
        rescue => e
            # puts "not re-created"
        end
        @@admin
    end

    def self.user
        begin
            @@user = User.create!([
        {
            name: "User Userson",
            email: "user_for_can_testing@shef.ac.uk",
            hhash: Password.create("qwe"),
            role: "ROLE_USER"
        }])[0]
        rescue => e
            # puts "not re-created"
        end
        @@user
    end

    # def self.get_token
    #     self.admin()
    #     post '/api/auth', params:
    #     {
    #         email: "admin_for_can_testing@shef.ac.uk",
    #         password: "qwe" 
    #     }

    #     data = JSON.parse(response.body)

    #     return data['Token']
    # end


end