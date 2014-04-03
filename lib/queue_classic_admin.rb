require 'sinatra'
require 'queue_classic'

module QueueClassic
  class Admin < Sinatra::Base
    get '/:table_name?' do
      @tables = get_table_names
      table_name = params[:table_name] || QC::TABLE_NAME
      halt(404, "Invalid table.") unless @tables.include?(table_name)

      @column_names = get_column_names(table_name)
      if params[:q_name]
        @queue_classic_jobs = execute("SELECT * FROM #{table_name} WHERE q_name = $1", [params[:q_name]])
      else
        @queue_classic_jobs = execute("SELECT * FROM #{table_name}")
      end

      @queue_counts = execute("SELECT q_name, count(*) FROM #{table_name} GROUP BY q_name")
      erb :index
    end

    post '/queue_classic_jobs/:id/destroy' do
      execute "DELETE FROM queue_classic_jobs WHERE id = $1", [params[:id]]
      redirect '/'
    end

    post '/queue_classic_jobs/:id/unlock' do
      execute "UPDATE queue_classic_jobs SET locked_at = NULL WHERE id = $1", [params[:id]]
      redirect '/'
    end

    post '/queue_classic_jobs/destroy_all' do
      execute "DELETE FROM queue_classic_jobs"
      redirect '/'
    end

    helpers do
      def get_column_names(table_name)
        @_column_name_cache ||= {}

        unless @_column_name_cache[table_name]
          columns = execute("SELECT column_name FROM information_schema.columns WHERE table_name = $1", [table_name]);
          @_column_name_cache[table_name] = columns.map {|column| column.column_name }
        end

        @_column_name_cache[table_name]
      end

      def get_table_names
        unless @_table_name_cache
          tables = execute("SELECT table_name FROM information_schema.tables WHERE table_name ILIKE 'queue_classic%'");
          @_table_name_cache = tables.map {|table| table.table_name }
        end

        @_table_name_cache
      end

      def q_name_pill_class(name)
        if params[:q_name] == name
          "active"
        else
          ""
        end
      end

      def execute(*args)
        QC.default_conn_adapter.connection.exec(*args).map{|h| OpenStruct.new(h)}
      end
    end
  end
end
