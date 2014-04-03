require 'sinatra'
require 'queue_classic'

module QueueClassic
  class Admin < Sinatra::Base
    get '/' do
      @queue_classic_jobs = QC.default_conn_adapter.execute("SELECT * FROM queue_classic_jobs").map{|h| OpenStruct.new(h)}
      erb :index
    end
  end
end
