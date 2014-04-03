require 'sinatra'
require 'queue_classic'

module QueueClassic
  class Admin < Sinatra::Base
    get '/' do
      @queue_classic_jobs = []
      erb :index
    end
  end
end
