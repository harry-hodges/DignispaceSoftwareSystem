class AddAnswerClass < ActiveRecord::Migration[7.0]
  def change
    create_table(:answers) do |t|
      
      ## Data Fields for Answer class
      t.timestamps
      
      t.string :contents
      
    end
    add_reference :answers, :question, index: true
    add_foreign_key :answers, :questions
    add_reference :answers, :user_group, index: true
    add_foreign_key :answers, :user_groups
  end
end
