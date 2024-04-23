class AddPotentialEditClass < ActiveRecord::Migration[7.0]
  def change

    create_table(:potential_edits) do |t|

      ## potential_edit Info    
      t.boolean :accepted

      t.string :editContents

    end

    add_reference :potential_edits, :answer, index: true
    add_foreign_key :potential_edits, :answers  
  end
end
