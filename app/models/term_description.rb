class TermDescription < ActiveRecord::Base
  belongs_to :person
  belongs_to :term, :class_name => "Term"
  #acts_as_list :scope => :term
  belongs_to :term_description, :foreign_key => "update_of_tag_id"
end
