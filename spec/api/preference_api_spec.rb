require 'rails_helper'
include BCrypt

RSpec.describe 'Preference API' do
    RSpec.configure do |config|
      config.include AuthCommon
    end

    before :each do
      @pref = Preference.create!([
      {
          id: 1,
          name: "Test Preference",
          value: "Test Value",
          user_id: Common.user.id
      }])
    end

    describe 'get list of user preferences' do
        it 'lists all possible preferences on the website' do
            get '/api/preference', headers: {'JILLAUTH' => token}
            assert Preference.find_by(id: @pref[0].id).name == "Test Preference"
        end
    end

    describe 'edit a preference' do
        it 'allow user to change preference value' do
            put "/api/preference/#{@pref[0].id}", params:
            {
                value: "Updated Value"
            }, headers: {'JILLAUTH' => token}
            @pref[0].reload
            assert Preference.find_by(id: @pref[0].id).value == "Updated Value"

            # Failsafe (ensure correct API response)
            data = JSON.parse(response.body)
            assert data['Message'].include? "Preference was successfully updated."
        end
    end

    describe 'add a preference' do
        it 'allow admin to add a new preference' do
            post '/api/preference/', params:
            {
                id: 2,
                name: "New Preference",
                value: "New Value"
            }, headers: {'JILLAUTH' => token}
            @new_pref = Preference.find_by(id: 2)
            assert @new_pref.name == "New Preference"

            # Failsafe (ensure correct API response)
            data = JSON.parse(response.body)
            assert data['Message'].include? "Preference was created."
        end
    end

    describe 'delete a preference' do
        it 'allow admin to delete an existing preference' do
            delete "/api/preference/#{@pref[0].id}", headers: {'JILLAUTH' => token}
            assert Preference.find_by(id: @pref[0].id) == nil

            # Failsafe (ensure correct API response)
            data = JSON.parse(response.body)
            assert data['Message'].include? "Preference was deleted."
        end
    end
end
