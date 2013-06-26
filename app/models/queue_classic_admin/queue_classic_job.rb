module QueueClassicAdmin
  class QueueClassicJob < ActiveRecord::Base
    self.table_name = 'queue_classic_jobs'

    def arguments
      JSON.parse(args)
    end
  end
end
