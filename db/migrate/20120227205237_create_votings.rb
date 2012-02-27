class CreateVotings < ActiveRecord::Migration
  def change
    create_table :votings do |t|
      t.string :question
      t.boolean :on_teachers

      t.timestamps
    end
  end
end
