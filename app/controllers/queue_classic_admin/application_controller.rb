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
      if params[:sort].present?
        @queue_classic_jobs = @queue_classic_jobs.reorder("#{params[:sort]} #{params[:dir]}")
      end
      @queue_classic_jobs
    end

    helper_method :stats
    def stats
      Stats.new
    end
  end
end
