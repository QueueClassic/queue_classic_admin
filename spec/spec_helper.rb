require_relative '../lib/queue_classic_admin.rb'

require 'capybara'
require 'capybara/rspec'

Capybara.app = QueueClassic::Admin.new

RSpec.configure do |config|
  config.before do
    execute_sql "DELETE FROM queue_classic_jobs"
  end
end

def execute_sql(sql, params = [])
  QC.default_conn_adapter.connection.exec(sql, params).to_a
end
