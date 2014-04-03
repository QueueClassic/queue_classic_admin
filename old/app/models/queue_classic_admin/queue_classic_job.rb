module QueueClassicAdmin
  class QueueClassicJob < ActiveRecord::Base
    include JobCommon
    self.table_name = 'queue_classic_jobs'
  end
end
