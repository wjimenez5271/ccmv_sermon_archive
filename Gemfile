source 'https://rubygems.org'

gem 'rails', '3.2.0'

group :development, :test do
    gem 'sqlite3'
    gem 'rspec-rails'
    gem 'guard-rspec'
end

## TODO Figure out what this is aactually called
group :production do
    gem 'mysql2'
end

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sprockets'
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer'

  gem 'uglifier', '>= 1.0.3'
  #gem 'compass', '>= 0.11.7'
  # Temporary until asset finding bug is fixed, then go back to the above line
  gem 'compass', :git => 'git://github.com/chriseppstein/compass.git', :branch => 'no_rails_integration'
  gem 'compass-rails', :git => 'git://github.com/Compass/compass-rails.git'
  
end

gem 'jquery-rails'

group :test do
    gem 'capybara'
    gem 'turn'
    gem 'rb-fsevent', :require => false
    gem 'growl'
    gem 'guard-spork'
    gem 'spork'
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
