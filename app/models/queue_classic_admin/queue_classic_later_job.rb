module QueueClassicAdmin
  class QueueClassicLaterJob < ActiveRecord::Base
    include JobCommon
    self.table_name = 'queue_classic_later_jobs'
  end
end
