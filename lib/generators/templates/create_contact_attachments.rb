class CreateContactAttachments < ActiveRecord::Migration

  def change
    create_table "trim_contact_attachments", :force => true do |t|
      t.integer  "contact_message_id",      :null => false
      t.string   "attachment_file_name"
      t.integer  "attachment_file_size"
      t.string   "attachment_content_type"
      t.datetime "attachment_updated_at"
      t.timestamps
    end

    add_index "trim_contact_attachments", ["contact_message_id"]
  end
  
end
