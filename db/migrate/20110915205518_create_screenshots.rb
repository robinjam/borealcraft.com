class CreateScreenshots < ActiveRecord::Migration
  def change
    create_table :screenshots do |t|
      t.references :user
      t.string :title
      t.text :description

      t.timestamps
    end
    add_index :screenshots, :user_id
  end
end
