class Voting < ActiveRecord::Base
  enum_attr :subject_type, %w(^students teachers)
  has_many :votes
  accepts_nested_attributes_for :votes, allow_destroy: true, reject_if: :reject_vote

  attr_accessor :male_priority
  attr_accessor :female_priority

  def completed_by?(student)
    votes.by_author(student).count > 0
  end

  def to_param
    "#{id}-#{question.parameterize}"
  end

  def reject_vote(attr)
    attr[:male_id] == "" and attr[:female_id] == ""
  end
end
