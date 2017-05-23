class AddIdToLater < ActiveRecord::Migration[4.2]
  def change
    if table_already_exists?(:queue_classic_later_jobs)
      add_column :queue_classic_later_jobs, :id, :primary_key
    end
  end

  private

  def table_already_exists?(table)
    if ActiveRecord::Base.connection.respond_to?(:data_source_exists?)
      ActiveRecord::Base.connection.data_source_exists?(table)
    else
      ActiveRecord::Base.connection.table_exists?(table)
    end
  end
end
