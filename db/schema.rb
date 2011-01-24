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

ActiveRecord::Schema.define(:version => 20110124140432) do

  create_table "career_companies", :force => true do |t|
    t.integer  "career_id"
    t.integer  "company_id"
    t.integer  "weight",     :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "career_jobs", :force => true do |t|
    t.integer  "career_id"
    t.integer  "job_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "career_jobs", ["career_id"], :name => "index_career_jobs_on_career_id"
  add_index "career_jobs", ["job_id"], :name => "index_career_jobs_on_job_id"

  create_table "career_students", :force => true do |t|
    t.integer  "career_id"
    t.integer  "student_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "score",      :default => 0, :null => false
  end

  add_index "career_students", ["student_id"], :name => "index_career_students_on_student_id"

  create_table "career_terms", :force => true do |t|
    t.integer  "career_id"
    t.integer  "term_id"
    t.integer  "weight",     :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "careers", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.string   "title",            :limit => 50, :default => ""
    t.text     "comment"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["commentable_type"], :name => "index_comments_on_commentable_type"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.string   "address_line1"
    t.string   "address_line2"
    t.string   "address_city"
    t.string   "address_state"
    t.string   "address_zip"
    t.integer  "ownership_category", :default => 0, :null => false
    t.text     "description"
    t.string   "founded"
    t.string   "website"
    t.integer  "size_category",      :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "company_files", :force => true do |t|
    t.integer  "company_id"
    t.integer  "student_id"
    t.integer  "rating"
    t.text     "notes"
    t.boolean  "starred",              :default => false, :null => false
    t.boolean  "dismissed",            :default => false, :null => false
    t.integer  "vote",                 :default => 0,     :null => false
    t.integer  "feed_score"
    t.datetime "feed_last_seen"
    t.datetime "feed_dismissed_until"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "company_files", ["company_id", "student_id"], :name => "index_company_files_on_company_id_and_student_id"
  add_index "company_files", ["company_id"], :name => "index_company_files_on_company_id"

  create_table "company_highlightings", :force => true do |t|
    t.integer  "company_id"
    t.integer  "student_id"
    t.integer  "reference_id"
    t.string   "reference_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "company_labelings", :force => true do |t|
    t.integer  "company_id"
    t.integer  "label_id"
    t.integer  "student_id"
    t.integer  "company_file_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "company_labelings", ["company_id", "label_id"], :name => "index_company_labelings_on_company_id_and_label_id"
  add_index "company_labelings", ["company_id"], :name => "index_company_labelings_on_company_id"

  create_table "company_terms", :force => true do |t|
    t.integer  "company_id"
    t.integer  "term_id"
    t.integer  "weight"
    t.integer  "last_updated_by_user_id"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "company_terms", ["company_id"], :name => "index_company_terms_on_company_id"

  create_table "course_ratings", :force => true do |t|
    t.integer  "student_id"
    t.integer  "course_id"
    t.integer  "difficulty"
    t.integer  "usefulness"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "course_ratings", ["course_id"], :name => "index_course_ratings_on_course_id"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["locked_by"], :name => "delayed_jobs_locked_by"
  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

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

  add_index "experiences", ["student_id"], :name => "index_experiences_on_student_id"

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

  add_index "job_students", ["job_id"], :name => "index_job_students_on_job_id"
  add_index "job_students", ["student_id"], :name => "index_job_students_on_student_id"

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

  add_index "jobs", ["company_id"], :name => "index_jobs_on_company_id"

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

  add_index "newsfeed_items", ["user_id"], :name => "index_newsfeed_items_on_user_id"

  create_table "periods", :force => true do |t|
    t.string   "season"
    t.integer  "year"
    t.integer  "school_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pfeed_deliveries", :force => true do |t|
    t.integer  "pfeed_receiver_id"
    t.string   "pfeed_receiver_type"
    t.integer  "pfeed_item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pfeed_items", :force => true do |t|
    t.string   "type"
    t.integer  "originator_id"
    t.string   "originator_type"
    t.integer  "participant_id"
    t.string   "participant_type"
    t.text     "data"
    t.datetime "expiry"
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

  create_table "school_students", :id => false, :force => true do |t|
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

  add_index "school_students", ["student_id"], :name => "index_school_students_on_student_id"

  create_table "schools", :force => true do |t|
    t.string   "name"
    t.string   "address_line1"
    t.string   "address_line2"
    t.string   "address_city"
    t.string   "address_state"
    t.string   "address_zip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "student_files", :force => true do |t|
    t.integer  "student_id"
    t.integer  "applyable_id"
    t.string   "applyable_type"
    t.integer  "rating"
    t.text     "notes"
    t.boolean  "starred",         :default => false, :null => false
    t.boolean  "dismissed",       :default => false, :null => false
    t.integer  "vote",            :default => 0,     :null => false
    t.integer  "feed_score"
    t.datetime "feed_last_seen"
    t.datetime "dismissed_until"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "student_files", ["student_id"], :name => "index_student_files_on_student_id"

  create_table "student_labelings", :force => true do |t|
    t.integer  "student_id"
    t.integer  "label_id"
    t.integer  "applyable_id"
    t.string   "applyable_type"
    t.integer  "student_file_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "student_labelings", ["student_file_id"], :name => "index_student_labelings_on_student_file_id"
  add_index "student_labelings", ["student_id", "label_id"], :name => "index_student_labelings_on_student_id_and_label_id"
  add_index "student_labelings", ["student_id"], :name => "index_student_labelings_on_student_id"

  create_table "student_terms", :force => true do |t|
    t.string   "details"
    t.integer  "student_id"
    t.integer  "term_id"
    t.string   "term_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "score",      :default => 0, :null => false
  end

  add_index "student_terms", ["student_id", "term_id"], :name => "index_student_terms_on_student_id_and_term_id"
  add_index "student_terms", ["student_id"], :name => "index_student_terms_on_student_id"

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

  create_table "term_attachments", :force => true do |t|
    t.integer  "term_id"
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.integer  "weight",          :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "term_attachments", ["attachable_id", "attachable_type"], :name => "index_term_attachments_on_attachable_id_and_attachable_type"
  add_index "term_attachments", ["term_id"], :name => "index_term_attachments_on_term_id"

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
    t.integer  "added_by_user_id"
    t.string   "course_abbrev"
    t.integer  "course_difficulty_sum_cache",   :default => 0, :null => false
    t.integer  "course_difficulty_count_cache", :default => 0, :null => false
    t.integer  "course_usefulness_sum_cache",   :default => 0, :null => false
    t.integer  "course_usefulness_count_cache", :default => 0, :null => false
    t.integer  "department_id"
    t.integer  "school_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "updates", :force => true do |t|
    t.integer  "user_id"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "updates", ["user_id"], :name => "index_updates_on_user_id"

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
    t.string   "token"
    t.string   "secret"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "",    :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "",    :null => false
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
    t.string   "type"
    t.float    "gpa"
    t.string   "hometown"
    t.text     "subtitle"
    t.integer  "phone"
    t.boolean  "gender_is_male"
    t.string   "ethnicity"
    t.text     "highlights"
    t.text     "fun_facts"
    t.string   "address_line1"
    t.string   "address_line2"
    t.string   "address_city"
    t.string   "address_state"
    t.string   "address_zip"
    t.string   "location"
    t.string   "languages"
    t.integer  "baseline_score",                      :default => 0,     :null => false
    t.integer  "company_id"
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "admin",                               :default => false, :null => false
    t.string   "website"
    t.string   "username"
    t.integer  "rep_alltime"
    t.integer  "rep_month"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username"

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  add_index "users_roles", ["role_id"], :name => "index_users_roles_on_role_id"
  add_index "users_roles", ["user_id"], :name => "index_users_roles_on_user_id"

end
