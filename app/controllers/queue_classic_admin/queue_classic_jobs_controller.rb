require_dependency "queue_classic_admin/application_controller"

module QueueClassicAdmin
  class QueueClassicJobsController < ApplicationController
    def index
      filter_jobs(QueueClassicJob)
    end

    def destroy
      @queue_classic_job = QueueClassicJob.find(params[:id])
      @queue_classic_job.destroy
      redirect_to queue_classic_jobs_url
    end

    private
    def index_path(*params)
      queue_classic_jobs_path(*params)
    end

    helper_method :index_path
  end
end
