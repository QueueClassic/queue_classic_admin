require_relative '../lib/queue_classic_admin.rb'

require 'capybara'
require 'capybara/rspec'

Capybara.app = QueueClassic::Admin.new

RSpec.configure do |config|
  config.before do
    QC.default_conn_adapter.connection.exec("DELETE FROM queue_classic_jobs")
  end
end
