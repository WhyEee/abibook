class AddDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :full_name, :string

    add_column :users, :student_id, :integer

    add_column :users, :role, :string

  end
end
