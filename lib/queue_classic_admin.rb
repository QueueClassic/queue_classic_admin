require 'sinatra'
require 'queue_classic'

module QueueClassic
  class Admin < Sinatra::Base
    get '/' do
      "Hello World"
    end
  end
end
