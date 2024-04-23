class AuditLogEntries < ActiveRecord::Migration[7.0]
  def change

    create_table(:audit_log_entries) do |t|
      
      ## audit_log_entries info    
      t.string :action

      t.string :details

      t.timestamps

    end

    add_reference :audit_log_entries, :user, index: true
    add_foreign_key :audit_log_entries, :users

    
    
    add_reference :audit_log_entries, :answer, index: true
    add_foreign_key :audit_log_entries, :answers 
  end
end
