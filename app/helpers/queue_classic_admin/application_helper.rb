module QueueClassicAdmin
  module ApplicationHelper
    def has_qc_later?
      QC.respond_to?(:enqueue_in) &&
        defined?(QC::Later) &&
        ActiveRecord::Base.connection.table_exists?(QC::Later::TABLE_NAME)
    end
  end
end
