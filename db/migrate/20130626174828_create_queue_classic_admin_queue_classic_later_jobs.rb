class CreateQueueClassicAdminQueueClassicLaterJobs < ActiveRecord::Migration
  def change
    create_table :queue_classic_admin_queue_classic_later_jobs do |t|

      t.timestamps
    end
  end
end
