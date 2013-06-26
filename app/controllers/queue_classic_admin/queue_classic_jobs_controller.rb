require_dependency "queue_classic_admin/application_controller"

module QueueClassicAdmin
  class QueueClassicJobsController < ApplicationController
    def index
      filter_jobs(QueueClassicJob)
    end

    def scheduled
      filter_jobs(QueueClassicLaterJob)
      render action: 'index'
    end

    def destroy
      @queue_classic_job = QueueClassicJob.find(params[:id])
      @queue_classic_job.destroy
      redirect_to queue_classic_jobs_url
    end
    private 

    def filter_jobs(klass)
      @queue_classic_jobs = klass.scoped
      if params[:q_name].present?
        @queue_classic_jobs = @queue_classic_jobs.where(q_name: params[:q_name])
      end
    end
  end
end
