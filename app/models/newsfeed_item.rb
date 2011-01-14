# from schema; please check to be sure this hasn't changed!
#
# create_table "newsfeed_items", :force => true do |t|
#   t.integer  "text"
#   t.string   "type"
#   t.integer  "reference_id"
#   t.string   "reference_type"
#   t.integer  "user_id"
#   t.integer  "entity_id"
#   t.string   "entity_type"
#   t.datetime "update_time"
#   t.datetime "created_at"
#   t.datetime "updated_at"
# end

class NewsfeedItem < ActiveRecord::Base
  belongs_to :entity, :polymorphic => true
  belongs_to :reference, :polymorphic => true
  belongs_to :user
  
  class NewsfeedUpdate < NewsfeedItem
  end
    
end

