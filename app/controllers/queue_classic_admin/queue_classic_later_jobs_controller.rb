require_dependency "queue_classic_admin/application_controller"

module QueueClassicAdmin
  class QueueClassicLaterJobsController < ApplicationController
    def index
      filter_jobs(QueueClassicLaterJob)
    end
  
    def destroy
      @queue_classic_later_job = QueueClassicLaterJob.find(params[:id])
      @queue_classic_later_job.destroy
      redirect_to queue_classic_later_jobs_url
    end

    private
    def index_path(*params)
      queue_classic_later_jobs_path(*params)
    end

    helper_method :index_path
  end
end
