class AddBubbleClass < ActiveRecord::Migration[7.0]
  def change
    create_table(:bubbles) do |t|
      
      t.string :name
    end
   
    add_reference :bubbles, :user_group, index: true
    add_foreign_key :bubbles, :user_groups
  end
end



