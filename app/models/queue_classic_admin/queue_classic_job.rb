module QueueClassicAdmin
  class QueueClassicJob < ActiveRecord::Base
    self.table_name = 'queue_classic_jobs'
    # attr_accessible :title, :body
  end
end
