source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.0'

gem 'actionview', '~> 5.2.4' # Addresses CVE-2019-5418.
gem 'administrate', '~> 0.12'
gem 'bootsnap', '~> 1.4', require: false
gem 'clearance', '~> 1.16'
gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'
gem 'loofah', '~> 2.4' # addresses CVE-2018-16468. This is not a direct dependency.
gem 'mu-result', '~> 1.2'
gem 'pg', '~> 1.2'
gem 'puma', '~> 3.12'
gem 'rack', '~> 2.0'
gem 'rails', '~> 5.2.1'
gem 'rollbar', '~> 2.18'
gem 'sass-rails', '~> 5.0'
gem 'turbolinks', '~> 5.2'
gem 'uglifier', '~> 4.2'
gem 'webpacker', '~> 4.0'

group :development, :test do
  gem 'byebug', '~> 10.0', platforms: [:mri, :mingw, :x64_mingw]
  gem 'dotenv-rails', '~> 2.5'
  gem 'rspec-rails', '~> 3.8'
  gem 'factory_bot_rails', '~> 5.1'
  gem 'pry', '~> 0.12'
end

group :development do
  gem 'web-console', '~> 3.7'
  gem 'listen', '~> 3.1'
  gem 'spring', '~> 2.1'
  gem 'spring-watcher-listen', '~> 2.0'
end

group :test do
  gem 'capybara', '~> 3.31'
  gem 'selenium-webdriver', '~> 3.142'
  gem 'chromedriver-helper', '~> 2.1'
  gem 'database_cleaner', '~> 1.8'
end

gem 'tzinfo-data', '~> 1.2', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
