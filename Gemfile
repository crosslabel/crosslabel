source 'https://rubygems.org'

ruby '2.2.0'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.6'
# Use postgresql as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

gem 'active_model_serializers', '~>0.8.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development
gem 'bower-rails', "~> 0.9.2"
gem 'rest-client'

# Admin backend
gem 'cancan', '~>1.6.10' #authorization

gem 'kaminari'
gem 'searchkick'

# Authentication
gem 'devise'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'uuidtools'

gem 'thin' #web server

gem 'paperclip', '~>4.2'
gem 'aws-sdk', '< 2.0'

gem "redis", "~> 3.0.1"
gem 'mandrill-api', '~> 1.0.53', require: "mandrill" # transactional emails
gem 'resque', '~> 1.25.2'
gem 'resque-scheduler', '~> 4.0.0'
gem 'analytics-ruby', '~> 2.0.0', :require => 'segment/analytics'

group :test do
  gem 'rspec-rails', '~> 3.0'
  gem "factory_girl_rails", "~> 4.0" # fixtures
  gem 'capybara'
  gem 'shoulda-matchers'
  gem 'ffaker'
  gem 'webmock'
  gem 'excon'
  gem 'database_cleaner', '~> 1.4.1'
  gem 'mock_redis'
end

group :production do
  gem 'rails_12factor'#heroku
  gem 'newrelic_rpm'
end

gem 'wicked'
gem 'money-rails'
gem 'gretel'
gem 'jquery-turbolinks'

# JavaScript runtime
gem 'execjs'
gem 'therubyracer'

group :development do
  gem 'capistrano', '~> 3.4.0'
  gem 'capistrano-bundler', '~> 1.1.2'
  gem 'capistrano-rails', '~> 1.1'
  gem 'capistrano-rbenv', '~> 2.0'
end

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# Add this if you're using rbenv

# Use debugger
# gem 'debugger', group: [:development, :test]
