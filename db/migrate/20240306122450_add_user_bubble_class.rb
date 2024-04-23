class AddUserBubbleClass < ActiveRecord::Migration[7.0]
  def change
    create_table(:user_bubbles) do |t|
      

    end
    add_reference :user_bubbles, :bubble, index: true
    add_foreign_key :user_bubbles, :bubbles
    
    add_reference :user_bubbles, :user, index: true
    add_foreign_key :user_bubbles, :users
  end
end
