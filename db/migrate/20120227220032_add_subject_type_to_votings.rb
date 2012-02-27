class AddSubjectTypeToVotings < ActiveRecord::Migration
  def change
    change_table :votings do |t|
      t.remove :on_teachers
      t.string :subject_type
    end
  end
end
