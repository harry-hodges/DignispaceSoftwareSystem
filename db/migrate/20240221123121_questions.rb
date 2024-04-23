class Questions < ActiveRecord::Migration[7.0]
  def change        
        create_table(:questions) do |t|
          ## Question Info
          t.string :contents
          t.string :title
          t.string :sensitivity
        end   
  end
end
