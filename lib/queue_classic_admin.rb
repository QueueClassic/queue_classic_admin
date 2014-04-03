require 'sinatra'
require 'queue_classic'

module QueueClassic
  class Admin < Sinatra::Base
    get '/' do
      if params[:q_name]
        @queue_classic_jobs = execute("SELECT * FROM queue_classic_jobs WHERE q_name = $1", [params[:q_name]])
      else
        @queue_classic_jobs = execute("SELECT * FROM queue_classic_jobs")
      end

      @queue_counts = execute("SELECT q_name, count(*) FROM queue_classic_jobs GROUP BY q_name")
      erb :index
    end

    helpers do
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
