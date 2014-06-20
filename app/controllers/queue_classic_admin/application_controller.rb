module QueueClassicAdmin
  class ApplicationController < ActionController::Base
    protected
    def filter_jobs(klass)
      @klass = klass
      @queue_classic_jobs = klass.order("id DESC")
      if params[:q_name].present?
        @queue_classic_jobs = @queue_classic_jobs.where(q_name: params[:q_name])
      end
      if params[:search].present?
        @queue_classic_jobs = @queue_classic_jobs.search(params[:search])
      end
      @queue_classic_jobs
    end
  end
end
