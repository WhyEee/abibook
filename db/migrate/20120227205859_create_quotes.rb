class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.string :category
      t.string :course
      t.string :term
      t.references :author
      t.text :content

      t.timestamps
    end

    add_index :quotes, :author_id
  end
end
