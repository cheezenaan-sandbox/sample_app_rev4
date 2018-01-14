# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "jbuilder", "~> 2.5"
gem "mysql2", ">= 0.3.18", "< 0.5"
gem "puma", "~> 3.7"
gem "rails", "~> 5.1.4"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"

group :development, :test do
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "hirb"
  gem "pry-byebug"
  gem "pry-coolline"
  gem "pry-doc"
  gem "pry-rails"
  gem "pry-stack_explorer"
  gem "rails-flog", require: "flog"
  gem "spring-commands-rspec"
end

group :development do
  gem "better_errors"
  gem "binding_of_caller"
  gem "brakeman"
  gem "bullet"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "rubocop", require: false
  gem "rufo"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

group :test do
  gem "capybara", require: false
  gem "capybara-screenshot"
  gem "factory_bot_rails"
  gem "guard"
  gem "guard-rspec", require: false
  gem "rspec-its"
  gem "rspec-rails"
  gem "selenium-webdriver", require: false
  gem "simplecov"
end
