class Quote < ActiveRecord::Base
  belongs_to :author, :class_name => 'Student'
end
