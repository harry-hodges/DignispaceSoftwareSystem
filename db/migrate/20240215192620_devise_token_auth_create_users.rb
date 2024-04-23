class DeviseTokenAuthCreateUsers < ActiveRecord::Migration[7.0]
  def change
    
    create_table(:users) do |t|
      

      ## User Info
      t.string :name
      
      t.string :email

      t.string :hhash

      t.string :token

      t.string :email_token

      t.string :role

      t.boolean :suspended

      t.timestamps

    end

    # add_index :users, :email, unique: true
    add_index :users, :token
    add_index :users, :email_token
    
   
  end
end
