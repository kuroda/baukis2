source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "~> 2.5"

gem "rails", "~> 6.0.0.beta1"
gem "pg", ">= 0.18", "< 2.0"
gem "puma", "~> 3.11"
gem "jbuilder", "~> 2.5"

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
end
