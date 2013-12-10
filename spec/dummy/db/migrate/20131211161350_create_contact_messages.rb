class CreateContactMessages < ActiveRecord::Migration

  create_table "trim_contact_messages", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.text     "message"
    t.string   "phone"
    t.string   "user_agent"
    t.string   "user_ip"
    t.boolean  "is_spam",            :default => false, :null => false
    t.integer  "contact_subject_id"
    t.timestamps
  end

  add_index "trim_contact_messages", ["contact_subject_id"]

end
