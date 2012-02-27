class Student < ActiveRecord::Base
  enum_attr :gender, %w(^male female), :nil => false

  has_one :user

  has_many :received_comments, :class_name => 'Comment', :foreign_key => :subject_id
  has_many :submitted_comments, :class_name => 'Comment', :foreign_key => :author_id

  has_many :received_male_votes, :class_name => 'Vote', :foreign_key => :male_id, :as => :votable
  has_many :received_female_votes, :class_name => 'Vote', :foreign_key => :female_id, :as => :votable
  has_many :submitted_votes, :class_name => 'Vote', :foreign_key => :author_id

  has_many :quotes, :foreign_key => :author_id


  def received_votes
    received_male_votes + received_female_votes
  end
end
