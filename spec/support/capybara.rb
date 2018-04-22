# frozen_string_literal: true

require "capybara/rspec"
require "selenium-webdriver"

Capybara.register_driver :selenium_remote do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    chromeOptions: {
      args: ["--headless", "--no-sandbox", "--disable--gpu", "--window-size=1280x800"],
    },
  )
  Capybara::Selenium::Driver.new(app,
                                 url: "http://chrome:4444/wd/hub",
                                 browser: :remote,
                                 desired_capabilities: capabilities)
end

Capybara.default_driver = :rake_test
Capybara.server_host = "0.0.0.0"

# TODO: Use puma as Capybara.server
Capybara.server = :webrick
