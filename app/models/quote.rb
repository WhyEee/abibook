class Quote < ActiveRecord::Base
  belongs_to :author, :class_name => 'Student'

  attr_accessible :course, :term, :content
end
