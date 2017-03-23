# messaging_board

# Dependencies
  ruby 2.3.0
  node
  phantomjs
# Install
if using rvm cd into app directory 
  gem install bundler
  bundle
  rake db:create
  rake db:migrate
  rake db:seeder
  rails s

# Tests
  rake db:test:prepare
  rspec
  
# Heroku 
  