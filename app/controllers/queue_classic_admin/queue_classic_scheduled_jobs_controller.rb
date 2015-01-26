require_dependency "queue_classic_admin/application_controller"

module QueueClassicAdmin
  class QueueClassicScheduledJobsController < ApplicationController
    def index
      filter_jobs(QueueClassicScheduledJob)
      @queue_classic_jobs = @queue_classic_jobs.paginate(page: params[:page])
    end
  
    def destroy
      @queue_classic_scheduled_job = QueueClassicScheduledJob.find(params[:id])
      @queue_classic_scheduled_job.destroy
      redirect_to queue_classic_scheduled_jobs_url
    end

    def destroy_all
      filter_jobs(QueueClassicScheduledJob).delete_all
      redirect_to queue_classic_jobs_url
    end

    private
    def index_path(*params)
      queue_classic_scheduled_jobs_path(*params)
    end

    def scheduled?
      true
    end

    helper_method :index_path
    helper_method :scheduled?
  end
end
