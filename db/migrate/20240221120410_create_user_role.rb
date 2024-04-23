class CreateUserRole < ActiveRecord::Migration[7.0]
  def change
    
    create_table(:user_roles) do |t|
      

      ## User Role
      t.string :role
      
    end

    add_reference :user_roles, :user_group, index: true
    add_foreign_key :user_roles, :user_groups

    add_reference :user_roles, :user, index: true
    add_foreign_key :user_roles, :users
   
  end
end
