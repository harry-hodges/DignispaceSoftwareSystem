class AddAlertClass < ActiveRecord::Migration[7.0]
  def change
    create_table(:alerts) do |t|
      

      ## User Info
      t.timestamps
      
      t.integer :active

      t.string :topic

      t.string :description

      t.string :web_link

      t.boolean :high_priority

    end
    add_reference :alerts, :user, index: true
    add_foreign_key :alerts, :users
  end
end
