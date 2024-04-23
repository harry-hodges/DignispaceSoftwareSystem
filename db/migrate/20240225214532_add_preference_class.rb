class AddPreferenceClass < ActiveRecord::Migration[7.0]
  def change
    create_table(:preferences) do |t|
      
      ## Data Fields for Preference class
      t.string :name
      
      t.string :value
      
    end
    add_reference :preferences, :user, index: true
    add_foreign_key :preferences, :users  
  end
end
