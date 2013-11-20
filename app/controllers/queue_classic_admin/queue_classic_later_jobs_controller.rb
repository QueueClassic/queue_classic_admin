require_dependency "queue_classic_admin/application_controller"

module QueueClassicAdmin
  class QueueClassicLaterJobsController < ApplicationController
    def index
      filter_jobs(QueueClassicLaterJob)
      @queue_classic_jobs = @queue_classic_jobs.paginate(page: params[:page])
    end
  
    def destroy
      @queue_classic_later_job = QueueClassicLaterJob.find(params[:id])
      @queue_classic_later_job.destroy
      redirect_to queue_classic_later_jobs_url
    end

    def destroy_all
      filter_jobs(QueueClassicLaterJob).delete_all
      redirect_to queue_classic_jobs_url
    end

    private
    def index_path(*params)
      queue_classic_later_jobs_path(*params)
    end

    helper_method :index_path
  end
end
