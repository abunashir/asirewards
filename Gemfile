source "https://rubygems.org"

ruby "2.3.1"

gem "airbrake", "~> 5.4"
gem "autoprefixer-rails", "~> 6.3.7"
gem "coffee-rails", "~> 4.1.0"
gem "delayed_job_active_record"
gem "flutie"
gem "high_voltage"
gem "jquery-rails"
gem "newrelic_rpm", ">= 3.9.8"
gem "pg"
gem "puma"
gem "rack-canonical-host"
gem "rails", "~> 4.2.7"
gem "recipient_interceptor"
gem "sass-rails", "~> 5.0.6"
gem "simple_form"
gem "title"
gem "uglifier"
gem "clearance"
gem "carrierwave"
gem "fog"
gem "pdfkit"
gem "render_anywhere", require: false
gem "bootstrap-sass", "~> 3.3.6"
gem "country_select"
gem "friendly_id", "~> 5.1.0"
gem "rmagick"
gem "paypal-sdk-rest"

group :development do
  gem "quiet_assets"
  gem "refills"
  gem "spring"
  gem "spring-commands-rspec"
  gem "web-console"
end

group :development, :test do
  gem "awesome_print"
  gem "bullet"
  gem "bundler-audit", require: false
  gem "dotenv-rails"
  gem "factory_girl_rails"
  gem "pry-byebug"
  gem "pry-rails"
  gem "rspec-rails", "~> 3.4.2"
  gem "wkhtmltopdf-binary"
end

group :test do
  gem "capybara-webkit"
  gem "database_cleaner"
  gem "formulaic"
  gem "launchy"
  gem "shoulda-matchers"
  gem "simplecov", require: false
  gem "timecop"
  gem "webmock"
  gem "pdf-reader"
end

group :staging, :production do
  gem "rack-timeout"
  gem "rails_12factor"
  gem "wkhtmltopdf-heroku"
end
