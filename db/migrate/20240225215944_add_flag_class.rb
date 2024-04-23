class AddFlagClass < ActiveRecord::Migration[7.0]
  def change
    create_table(:flags) do |t|
      
      ## Data Fields for Flag class
      t.timestamps
      
      t.boolean :active

      t.string :reason

      t.string :remarks
      
    end
    add_reference :flags, :answer, index: true
    add_foreign_key :flags, :answers
  end
end