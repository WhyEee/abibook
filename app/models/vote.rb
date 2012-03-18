class Vote < ActiveRecord::Base
  belongs_to :voting

  belongs_to :author, :class_name => 'Student'
  belongs_to :male, :polymorphic => true, :foreign_key => :male_id
  belongs_to :female, :polymorphic => true, :foreign_key => :female_id

  def self.by_author(author)
    where author_id: author.id
  end
end
