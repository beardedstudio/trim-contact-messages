class CreateContactSubjects < ActiveRecord::Migration

  def change
    create_table "trim_contact_subjects", :force => true do |t|
      t.string   "name"
      t.string   "email"
      t.timestamps
    end
  end

end
