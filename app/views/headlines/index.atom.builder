atom_feed do |feed|
  feed.title "BorealCraft News"
  feed.updated @headlines.first.created_at unless @headlines.empty?

  @headlines.each do |headline|
    feed.entry(headline) do |entry|
      entry.title headline.title
      entry.content markdown(headline.content), type: 'html'

      entry.author do |author|
        author.name "" # TODO: Add author column to headlines table
      end
    end
  end
end
