class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :name
      t.string :first_name
      t.date :date_of_birth
      t.string :gender

      t.string :exam1
      t.string :exam2
      t.string :exam3
      t.string :exam4

      t.string :motto
      t.string :career
      t.string :shirt_size

      t.timestamps
    end

    add_index :students, [:name, :first_name], :unique => true
  end
end
