class Voting < ActiveRecord::Base
  enum_attr :subject_type, %w(^students teachers)
  has_many :votes
end
