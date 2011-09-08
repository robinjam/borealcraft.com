class CreatePages < ActiveRecord::Migration
  class Page < ActiveRecord::Base; end
  class Post < ActiveRecord::Base; end
  
  def up
    create_table :pages do |t|
      t.string :title
      t.text :content

      t.timestamps
    end

    Page.reset_column_information

    Post.where(type: "Page").each do |post|
      p = Page.new(title: post.title, content: post.content)
      p.created_at = post.created_at
      p.updated_at = post.updated_at
      p.save!
    end

    say "#{Page.count} Page(s) migrated."
  end

  def down
    drop_table :pages
  end
end
