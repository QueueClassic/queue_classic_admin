module QueueClassicAdmin
  class ApplicationController < ActionController::Base
    protected
    def filter_jobs(klass)
      @klass = klass
      @queue_classic_jobs = klass.scoped
      if params[:q_name].present?
        @queue_classic_jobs = @queue_classic_jobs.where(q_name: params[:q_name])
      end
    end
  end
end
