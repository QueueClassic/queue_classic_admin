class AddIdToLater < ActiveRecord::Migration
  def change
    add_column :queue_classic_later_jobs, :id, :primary_key
  end
end
