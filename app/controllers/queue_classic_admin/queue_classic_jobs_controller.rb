require_dependency "queue_classic_admin/application_controller"

module QueueClassicAdmin
  class QueueClassicJobsController < ApplicationController
    before_filter :get_job, only: [:destroy, :unlock, :custom]
    def index
      filter_jobs(QueueClassicJob)
      @queue_classic_jobs = @queue_classic_jobs.paginate(page: params[:page])
    end

    def destroy
      @queue_classic_job.destroy
      redirect_to :back
    end

    def destroy_all
      filter_jobs(QueueClassicJob).delete_all
      redirect_to queue_classic_jobs_url
    end

    def unlock_all
      filter_jobs(QueueClassicJob).where('locked_at < ?', 5.minutes.ago).update_all(locked_at: nil)
      redirect_to queue_classic_jobs_url
    end

    def unlock
      @queue_classic_job.locked_at = nil
      @queue_classic_job.save
      redirect_to :back
    end

    def custom
      custom_action = QueueClassicAdmin.custom_actions[params[:custom_action]]
      custom_action.action.call(@queue_classic_job)
      redirect_to :back
    end

    private
    def index_path(*params)
      queue_classic_jobs_path(*params)
    end

    def get_job
      @queue_classic_job = QueueClassicJob.find(params[:id])
    end

    def later?
      false
    end

    helper_method :index_path
    helper_method :later?
  end
end
