require_dependency "queue_classic_admin/application_controller"

module QueueClassicAdmin
  class QueueClassicJobsController < ApplicationController
    before_filter :get_job, only: [:destroy, :unlock]
    def index
      filter_jobs(QueueClassicJob)
      @queue_classic_jobs = @queue_classic_jobs.paginate(page: params[:page])
    end

    def destroy
      @queue_classic_job.destroy
      redirect_to queue_classic_jobs_url
    end

    def destroy_all
      filter_jobs(QueueClassicJob).delete_all
      redirect_to queue_classic_jobs_url
    end

    def unlock
      @queue_classic_job.locked_at = nil
      @queue_classic_job.save
      redirect_to queue_classic_jobs_url
    end

    private
    def index_path(*params)
      queue_classic_jobs_path(*params)
    end

    def get_job
      @queue_classic_job = QueueClassicJob.find(params[:id])
    end

    helper_method :index_path
  end
end
