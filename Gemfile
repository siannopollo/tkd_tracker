source 'https://rubygems.org'

gem 'rails', '3.2.1'


# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'pg'



# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer'

  gem 'uglifier', '>= 1.0.3'
end

gem 'mootools-rails'

gem 'calendar_date_select', :git => 'git://github.com/paneq/calendar_date_select.git'

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
group :development do
  gem 'sqlite3'
end

group :test do
  gem 'rspec-rails', '~> 2.8.1'
  gem 'rspec'
  gem 'syntax'
  gem 'timecop', '~> 0.3.5'
  gem 'capybara'
  gem 'database_cleaner'
  gem "factory_girl_rails", "~> 4.0"
  gem 'cucumber-rails', '~> 1.2.1', :require => false
  gem 'cucumber'
  gem 'launchy'
  if RUBY_PLATFORM =~ /(win32|w32)/
    gem "win32console", '1.3.0'
  end
  gem "minitest"
  gem "minitest-reporters", '>= 0.5.0'
end
