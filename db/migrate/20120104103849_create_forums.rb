class CreateForums < ActiveRecord::Migration
  def change
    create_table :forums do |t|
      t.references :category
      t.string :title
      t.string :description

      t.timestamps
    end
    add_index :forums, :category_id
  end
end
