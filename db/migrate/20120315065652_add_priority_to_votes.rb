class AddPriorityToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :male_priority, :integer

    add_column :votes, :female_priority, :integer

  end
end
