module QueueClassicAdmin
  class ApplicationController < ActionController::Base
    protected
    def filter_jobs(klass)
      @klass = klass
      if self.class == QueueClassicScheduledJobsController
        @scoped_jobs = klass.scheduled
      else
        @scoped_jobs = klass.ready
      end

      @queue_classic_jobs = klass.order("id DESC")
      if params[:q_name].present?
        @queue_classic_jobs = @queue_classic_jobs.where(q_name: params[:q_name])
      end
      if params[:search].present?
        @queue_classic_jobs = @queue_classic_jobs.search(params[:search])
      end
      if params[:sort].present?
        @queue_classic_jobs = @queue_classic_jobs.reorder("#{params[:sort]} #{params[:dir]} NULLS LAST")
      end
      @queue_classic_jobs
    end
  end
end
