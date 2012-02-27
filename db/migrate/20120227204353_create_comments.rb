class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :subject
      t.references :author
      t.text :content

      t.timestamps
    end

    add_index :comments, [:subject_id, :author_id], :unique => true
  end
end
