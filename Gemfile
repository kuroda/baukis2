source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "~> 2.5"

gem "rails", "~> 6.0.0.beta3"
gem "pg", ">= 0.18", "< 2.0"
gem "puma", "~> 3.11"
gem "jbuilder", "~> 2.5"
gem "bcrypt", "~> 3.1.7"

gem "bootsnap", ">= 1.1.0", require: false

gem "webpacker"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "selenium-webdriver"
  gem "chromedriver-helper"

  %w[rspec-core rspec-expectations rspec-mocks rspec-support].each do |lib|
    gem lib, :git => "https://github.com/rspec/#{lib}.git", :branch => "master"
  end

  gem "rspec-rails", git: "https://github.com/rspec/rspec-rails", branch: "4-0-dev"

  gem "factory_bot_rails", "~> 5.0.1"
end
