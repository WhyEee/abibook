class Teacher < ActiveRecord::Base
  enum_attr :gender, %w(^male female), :nil => false

  has_many :male_votes, :class_name => 'Vote', :foreign_key => :male_id, :as => :male
  has_many :female_votes, :class_name => 'Vote', :foreign_key => :female_id, :as => :female

  def votes
    male_votes + female_votes
  end

  def to_s
    is_male? ? "Herr #{name}" : "Frau #{name}"
  end
end
