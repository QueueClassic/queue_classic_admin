class AddCreatedColumn < ActiveRecord::Migration[4.2]
  def up
    %w(queue_classic_later_jobs).each do |table|
      if table_already_exists?(table)
        execute "ALTER TABLE #{table} ADD COLUMN created_at TIMESTAMP NOT NULL DEFAULT now();"
      else
        say "Skipping migration because table #{table} does not exist"
      end
    end
  end

  def down
    %w(queue_classic_later_jobs).each do |table|
      remove_column table, :created_at
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
