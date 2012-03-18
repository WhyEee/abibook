class AddHintToVotings < ActiveRecord::Migration
  def change
    add_column :votings, :hint, :string

  end
end
