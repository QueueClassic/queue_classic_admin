# This migration comes from queue_classic_admin (originally 20130626182618)
class AddIdToLater < ActiveRecord::Migration
  def change
    if ActiveRecord::Base.connection.table_exists?(:queue_classic_later_jobs)
      add_column :queue_classic_later_jobs, :id, :primary_key
    end
  end
end
