# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110116082631) do

  create_table "career_jobs", :force => true do |t|
    t.integer  "career_id"
    t.integer  "job_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "career_students", :force => true do |t|
    t.integer  "career_id"
    t.integer  "student_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "careers", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "term_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clubs", :force => true do |t|
    t.integer  "term_id"
    t.string   "name"
    t.text     "description"
    t.integer  "added_by_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.string   "address_line1"
    t.string   "address_line2"
    t.string   "address_city"
    t.string   "address_state"
    t.string   "address_zip"
    t.string   "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.string   "founded"
    t.string   "website"
    t.integer  "size_category"
  end

  create_table "company_feeds", :force => true do |t|
    t.integer  "company_id"
    t.integer  "student_id"
    t.integer  "score"
    t.datetime "last_seen"
    t.datetime "dismissed_until"
    t.boolean  "dismissed",       :default => false
    t.boolean  "deleted",         :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "company_files", :force => true do |t|
    t.integer  "company_id"
    t.integer  "student_id"
    t.integer  "rating"
    t.text     "notes"
    t.boolean  "starred",    :default => false, :null => false
    t.boolean  "dismissed",  :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "vote",       :default => 0,     :null => false
  end

  create_table "company_labelings", :force => true do |t|
    t.integer  "company_id"
    t.integer  "label_id"
    t.integer  "student_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "company_terms", :force => true do |t|
    t.integer  "company_id"
    t.integer  "term_id"
    t.integer  "weight"
    t.integer  "last_updated_by_user_id"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "course_ratings", :force => true do |t|
    t.integer  "student_id"
    t.integer  "course_id"
    t.integer  "difficulty"
    t.integer  "usefulness"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "course_students", :force => true do |t|
    t.integer  "student_id"
    t.integer  "course_id"
    t.integer  "period_id"
    t.text     "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courses", :force => true do |t|
    t.string   "name"
    t.string   "abbrev"
    t.integer  "department_id"
    t.string   "description"
    t.integer  "term_id"
    t.integer  "difficulty_sum_cache",   :default => 0, :null => false
    t.integer  "difficulty_count_cache", :default => 0, :null => false
    t.integer  "usefulness_sum_cache",   :default => 0, :null => false
    t.integer  "usefulness_count_cache", :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "departments", :force => true do |t|
    t.string   "name"
    t.integer  "school_id"
    t.integer  "term_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "experiences", :force => true do |t|
    t.integer  "student_id"
    t.date     "startdate"
    t.date     "enddate"
    t.string   "job_title"
    t.text     "description"
    t.string   "location"
    t.string   "type"
    t.integer  "company_id"
    t.integer  "club_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "followings", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "job_students", :force => true do |t|
    t.integer  "job_id"
    t.integer  "student_id"
    t.boolean  "applied"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "jobs", :force => true do |t|
    t.integer  "company_id"
    t.string   "title"
    t.text     "responsibilities"
    t.text     "basic_qualifications"
    t.text     "desired_qualifications"
    t.text     "other_information"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "labels", :force => true do |t|
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "newsfeed_items", :force => true do |t|
    t.text     "text"
    t.string   "type"
    t.integer  "reference_id"
    t.string   "reference_type"
    t.integer  "user_id"
    t.integer  "entity_id"
    t.string   "entity_type"
    t.datetime "update_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "periods", :force => true do |t|
    t.string   "season"
    t.integer  "year"
    t.integer  "school_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recruiters", :force => true do |t|
    t.integer  "phone"
    t.integer  "company_id"
    t.integer  "user_id"
    t.string   "address_line1"
    t.string   "address_line2"
    t.string   "address_city"
    t.string   "address_state"
    t.string   "address_zip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rep_transactions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "rep_change"
    t.integer  "transaction_type"
    t.integer  "reference_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string "name"
  end

  create_table "school_student", :id => false, :force => true do |t|
    t.integer  "school_id"
    t.integer  "student_id"
    t.date     "startdate"
    t.date     "enddate"
    t.text     "details"
    t.text     "degree_name"
    t.integer  "department_id"
    t.float    "gpa"
    t.boolean  "completed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schools", :force => true do |t|
    t.string   "name"
    t.integer  "term_id"
    t.string   "address_line1"
    t.string   "address_line2"
    t.string   "address_city"
    t.string   "address_state"
    t.string   "address_zip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "student_feeds", :force => true do |t|
    t.integer  "student_id"
    t.integer  "company_id"
    t.integer  "job_id"
    t.integer  "score"
    t.datetime "last_seen"
    t.datetime "dismissed_until"
    t.boolean  "dismissed",       :default => false
    t.boolean  "deleted",         :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "student_files", :force => true do |t|
    t.integer  "student_id"
    t.integer  "company_id"
    t.integer  "job_id"
    t.integer  "rating"
    t.text     "notes"
    t.boolean  "starred",    :default => false, :null => false
    t.boolean  "dismissed",  :default => false, :null => false
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "vote",       :default => 0,     :null => false
  end

  create_table "student_labelings", :force => true do |t|
    t.integer  "student_id"
    t.integer  "label_id"
    t.integer  "company_id"
    t.integer  "job_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "student_term", :force => true do |t|
    t.string   "details"
    t.integer  "student_id"
    t.integer  "term_id"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "students", :force => true do |t|
    t.float    "gpa"
    t.string   "hometown"
    t.text     "subtitle"
    t.integer  "phone"
    t.text     "highlights"
    t.text     "fun_facts"
    t.string   "address_line1"
    t.string   "address_line2"
    t.string   "address_city"
    t.string   "address_state"
    t.string   "address_zip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "address_id"
  end

  create_table "tasks", :force => true do |t|
    t.string   "name"
    t.text     "text"
    t.integer  "reference_id"
    t.integer  "reference_type"
    t.boolean  "is_reused"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "term_descriptions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "term_id"
    t.integer  "update_of_term_description_id"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  create_table "terms", :force => true do |t|
    t.string   "type"
    t.string   "name"
    t.string   "location"
    t.integer  "category_id"
    t.text     "description"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "entity_id"
    t.string   "entity_type"
  end

  create_table "updates", :force => true do |t|
    t.integer  "user_id"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_tasks", :force => true do |t|
    t.integer  "user_id"
    t.integer  "task_id"
    t.integer  "task_type"
    t.integer  "reference_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_tokens", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "rep_alltime"
    t.integer  "rep_month"
    t.boolean  "gender_is_male"
    t.integer  "ethnicity_id"
    t.string   "entity_type"
    t.integer  "entity_id"
    t.string   "first_name"
    t.string   "last_name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  add_index "users_roles", ["role_id"], :name => "index_users_roles_on_role_id"
  add_index "users_roles", ["user_id"], :name => "index_users_roles_on_user_id"

end
