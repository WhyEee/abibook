class RemoveIndexFromVotes < ActiveRecord::Migration
  def change
    remove_index :votes, [:voting_id, :author_id]
    add_index :votes, [:voting_id, :author_id]
  end
end
