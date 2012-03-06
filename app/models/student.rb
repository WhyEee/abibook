#Encoding: UTF-8
class Student < ActiveRecord::Base
  enum_attr :gender, %w(^male female), :nil => false
  enum_attr :shirt_size, %w(xs s m l xl xxl) do
    label xs: 'Größe XS'
    label s: 'Größe S'
    label m: 'Größe M'
    label l: 'Größe L'
    label xl: 'Größe XL'
    label xxl: 'Größe XXL'
  end

  attr_accessible :career, :motto, :shirt_size

  has_one :user

  has_many :received_comments, :class_name => 'Comment', :foreign_key => :subject_id
  has_many :submitted_comments, :class_name => 'Comment', :foreign_key => :author_id

  has_many :received_male_votes, :class_name => 'Vote', :foreign_key => :male_id, :as => :male
  has_many :received_female_votes, :class_name => 'Vote', :foreign_key => :female_id, :as => :female
  has_many :submitted_votes, :class_name => 'Vote', :foreign_key => :author_id

  has_many :quotes, :foreign_key => :author_id


  def full_name
    "#{first_name} #{name}"
  end

  def sortable_name
    "#{name}, #{first_name}"
  end

  def received_votes
    received_male_votes + received_female_votes
  end

  def dob_formatted
    date_of_birth.strftime '%d.%m.%Y'
  end
end
