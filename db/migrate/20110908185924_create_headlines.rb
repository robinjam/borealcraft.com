class CreateHeadlines < ActiveRecord::Migration
  class Headline < ActiveRecord::Base; end
  class Post < ActiveRecord::Base
    set_inheritance_column :none
  end
  
  def up
    create_table :headlines do |t|
      t.string :title
      t.text :content

      t.timestamps
    end

    Headline.reset_column_information

    Post.where(type: "NewsPost").each do |news_post|
      h = Headline.new(title: news_post.title, content: news_post.content)
      h.created_at = news_post.created_at
      h.updated_at = news_post.updated_at
      h.save!
    end

    say "#{Headline.count} NewsPost(s) migrated to Headline(s)."
  end

  def down
    drop_table :headlines
  end
end
