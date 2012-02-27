class Comment < ActiveRecord::Base
  belongs_to :subject, :class_name => 'Student'
  belongs_to :author, :class_name => 'Student'
end
