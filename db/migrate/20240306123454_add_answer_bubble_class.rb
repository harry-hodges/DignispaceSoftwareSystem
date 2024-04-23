class AddAnswerBubbleClass < ActiveRecord::Migration[7.0]
  def change
    create_table(:answer_bubbles) do |t|
      
    end
    add_reference :answer_bubbles, :bubble, index: true
    add_foreign_key :answer_bubbles, :bubbles
    
    add_reference :answer_bubbles, :answer, index: true
    add_foreign_key :answer_bubbles, :answers
  end
end
