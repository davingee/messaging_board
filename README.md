# messaging_board

# Dependencies
  ruby 2.3.0
  node
  phantomjs
# Install
  if using rvm cd into app directory <br />
  gem install bundler<br />
  bundle<br />
  rake db:create<br />
  rake db:migrate<br />
  rake db:seeder<br />
  rails s<br />

# Tests
  rake db:test:prepare
  rspec

# Heroku
  https://guarded-ravine-77432.herokuapp.com/