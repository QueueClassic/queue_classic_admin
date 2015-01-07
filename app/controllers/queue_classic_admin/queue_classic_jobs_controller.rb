require_dependency "queue_classic_admin/application_controller"

module QueueClassicAdmin
  class QueueClassicJobsController < ApplicationController
    before_filter :get_job, only: [:destroy, :unlock, :custom, :show]
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

    def bulk_custom_action
      jobs = filter_jobs(QueueClassicJob)

      custom_action = QueueClassicAdmin.custom_bulk_actions[params[:custom_action]]
      custom_action.action.call(jobs)

      redirect_to queue_classic_jobs_url
    end

    def unlock
      @queue_classic_job.locked_at = nil
      @queue_classic_job.save
      redirect_to :back
    end

    def show
      query = "SELECT * FROM pg_catalog.pg_locks lock JOIN pg_catalog.pg_stat_activity stat ON lock.pid = stat.pid WHERE lock.pid = #{@queue_classic_job.locked_by.to_i}"
      @locks = QueueClassicJob.connection.execute(query)
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
