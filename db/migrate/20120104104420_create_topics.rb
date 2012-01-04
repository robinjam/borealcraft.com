class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.references :forum
      t.string :title
      t.boolean :locked
      t.boolean :sticky

      t.timestamps
    end
    add_index :topics, :forum_id
  end
end
