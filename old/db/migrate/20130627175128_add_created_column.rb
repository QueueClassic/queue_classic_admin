class AddCreatedColumn < ActiveRecord::Migration
  def up
    %w(queue_classic_later_jobs queue_classic_jobs).each do |table|
      execute "ALTER TABLE #{table} ADD COLUMN created_at TIMESTAMP NOT NULL DEFAULT now();"
    end
  end

  def down
    %w(queue_classic_later_jobs queue_classic_jobs).each do |table|
      remove_column table, :created_at
    end
  end
end
