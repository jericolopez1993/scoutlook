source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.1'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby
gem "therubyracer"

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
# gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
#gem 'bootsnap', '>= 1.1.0', require: false
gem 'bootsnap', '= 1.1.6', require: false
gem 'devise'
gem 'tinymce-rails'
gem 'jquery-inputmask-rails', github: 'knapo/jquery-inputmask-rails'
gem "rolify"
gem "select2-rails"
gem 'pundit'
gem "sentry-raven"
gem 'seed_dump'
gem 'httparty'
gem "audited", "~> 4.7"
gem 'whenever', require: false
gem 'pdfkit' # Reading and Generating a PDF from HTML Pages
gem 'wkhtmltopdf-binary'
gem 'truncate_html' # Removing HTML codes to Note fields
gem 'delayed_job_active_record'
gem 'daemons'
gem "aws-sdk-s3", require: false # AWS requirement for Active Storage
gem 'twilio-ruby' # twilio gem
gem 'e164'
gem 'redis', '~> 3.0'
gem 'ajax-datatables-rails', git: 'https://github.com/jbox-web/ajax-datatables-rails.git'
gem 'draper'
gem "delayed_job_web"


group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'cucumber-rails', :require => false
  gem 'selenium-webdriver'
  gem 'rspec-rails', '~> 3.8'
  # database_cleaner is not required, but highly recommended
  gem 'database_cleaner'
  gem 'capistrano',         require: false
  gem 'capistrano-rvm',     require: false
  gem 'capistrano-rails',   require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano3-puma',   require: false
  gem 'capistrano3-delayed-job', '= 1.7.6'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
# gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
