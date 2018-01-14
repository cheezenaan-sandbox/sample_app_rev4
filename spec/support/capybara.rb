# frozen_string_literal: true

require "capybara/rspec"
require "selenium-webdriver"

Capybara.register_driver :selenium_remote do |app|
  Capybara::Selenium::Driver.new(app,
                                 url: "http://chrome:4444/wd/hub",
                                 browser: :remote,
                                 desired_capabilities: :chrome)
end

Capybara.default_driver = :rake_test
