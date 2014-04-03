require_relative '../lib/queue_classic_admin.rb'

require 'capybara'
require 'capybara/rspec'

Capybara.app = QueueClassic::Admin.new
