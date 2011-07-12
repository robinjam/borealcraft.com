server "staging.mine.robinjam.net", :app, :web, :db, :primary => true
set :deploy_to, "/srv/www/mine.robinjam.net/staging"
set :branch, "dev"
