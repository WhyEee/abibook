class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :voting
      t.references :author
      t.references :male, :polymorphic => true
      t.references :female, :polymorphic => true

      t.timestamps
    end

    add_index :votes, [:voting_id, :author_id], :unique => true
    add_index :votes, :author_id
  end
end
