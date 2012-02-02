class CollapsedMigration < ActiveRecord::Migration
  def up
    create_table "attendances", :force => true do |t|
      t.integer   "student_id"
      t.integer   "number_of_classes"
      t.timestamp "created_at"
      t.timestamp "updated_at"
      t.date      "date"
    end
    
    create_table "schools", :force => true do |t|
      t.string    "name"
      t.timestamp "created_at"
      t.timestamp "updated_at"
    end
    
    create_table "students", :force => true do |t|
      t.string    "first_name"
      t.string    "last_name"
      t.integer   "rank"
      t.date      "last_test"
      t.integer   "school_id"
      t.string    "email_address"
      t.string    "phone"
      t.timestamp "created_at"
      t.timestamp "updated_at"
      t.string    "phone_two"
      t.string    "parent_name"
      t.boolean   "inactive"
    end
    
    create_table "tkd_tests", :force => true do |t|
      t.integer  "student_id"
      t.date     "date"
      t.string   "result"
      t.string   "comments"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "tester"
    end
  end
  
  def down
    raise 'Irreversible Migration'
  end
end
