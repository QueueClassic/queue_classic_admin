module QueueClassicAdmin
  class QueueClassicJob < ActiveRecord::Base
    include JobCommon
    self.table_name = 'queue_classic_jobs'

    scope :ready, -> { where("queue_classic_jobs.scheduled_at <= now()") }
    scope :scheduled, -> { where("queue_classic_jobs.scheduled_at > now()") }
  end
end
