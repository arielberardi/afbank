class ApplicationJob < ActiveJob::Base
  sidekiq_options retry: 3
  sidekiq_options backtrace: true
end
