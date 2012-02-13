source 'https://rubygems.org'

gem 'rails', '3.2.1'

group :development, :test do
    gem 'sqlite3'
    gem 'rspec-rails'
    gem 'guard-rspec'
    gem 'shoulda-matchers'
end

group :development do
  gem 'annotate', '~> 2.4.1.beta'
  gem 'faker'
end

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
  gem 'compass-rails'
end

gem 'jquery-rails'
gem 'will_paginate'
#gem 'searchlogic'
gem 'handles_sortable_columns'

group :test do
    gem 'capybara'
    gem 'turn'
    gem 'rb-fsevent', :require => false
    gem 'growl'
    gem 'guard-spork'
    gem 'spork'
    gem 'factory_girl_rails'
end

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
group :development do
  #gem 'ruby-debug19', :require => 'ruby-debug'
  # The two lines below are necessary because ruby-debug doesn't work with 1.9.3
  # Yes, really.
  #gem 'ruby-debug-base19', '~> 0.11.26'
  #gem 'linecache19', '~> 0.5.13'
end
