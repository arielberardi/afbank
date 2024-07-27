require 'test_helper'

Selenium::WebDriver::Chrome::Service.driver_path =
  '/usr/bin/chromedriver'

Capybara.register_driver :root_headless_chrome do |app|
  options = Selenium::WebDriver::Options.chrome(
    args: %w[
      headless
      disable-gpu
      no-sandbox
      disable-dev-shm-usage
      whitelisted-ips
    ],
    logging_prefs: { browser: 'ALL' }
  )
  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    options:
  )
end

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :rack_test
end

class BrowserSystemTestCase < ApplicationSystemTestCase
  driven_by :root_headless_chrome, screen_size: [1400, 1400]
end
