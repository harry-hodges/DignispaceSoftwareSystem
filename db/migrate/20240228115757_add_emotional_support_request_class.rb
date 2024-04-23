class AddEmotionalSupportRequestClass < ActiveRecord::Migration[7.0]
  def change

    create_table(:emotional_support_requests) do |t|

      ## emotional_support_request Info    
      t.timestamps

    end

    add_reference :emotional_support_requests, :user, index: true
    add_foreign_key :emotional_support_requests, :users  
  end
end
