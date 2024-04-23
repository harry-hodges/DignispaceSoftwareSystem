class CreateUserGroup < ActiveRecord::Migration[7.0]
  def change
    
    create_table(:user_groups) do |t|
      
      ## User Info
      t.string :name
      
      t.string :image

      t.boolean :content_released

    end
  end
end
