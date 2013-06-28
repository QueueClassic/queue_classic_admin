require_dependency "queue_classic_admin/application_controller"

module QueueClassicAdmin
  class QueueClassicJobsController < ApplicationController
    def index
      filter_jobs(QueueClassicJob)
      @queue_classic_jobs = @queue_classic_jobs.paginate(page: params[:page])
    end

    def destroy
      @queue_classic_job = QueueClassicJob.find(params[:id])
      @queue_classic_job.destroy
      redirect_to queue_classic_jobs_url
    end

    def purge
      filter_jobs(QueueClassicJob).delete_all
      redirect_to queue_classic_jobs_url
    end

    private
    def index_path(*params)
      queue_classic_jobs_path(*params)
    end

    helper_method :index_path
  end
end
