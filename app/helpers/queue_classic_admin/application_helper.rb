module QueueClassicAdmin
  module ApplicationHelper
    def has_qc_later?
      QC.respond_to?(:enqueue_in) &&
        defined?(QC::Later) &&
        ActiveRecord::Base.connection.table_exists?(QC::Later::TABLE_NAME)
    end

    def sortable_column(name, title)
      opts = {sort: name}
      opts[:dir] = (params[:dir] == "asc" ? "desc" : "asc")
      content_tag :th do
        link_to title, params.merge(opts)
      end
    end
  end
end
