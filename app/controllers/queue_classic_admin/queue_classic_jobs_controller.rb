require_dependency "queue_classic_admin/application_controller"

module QueueClassicAdmin
  class QueueClassicJobsController < ApplicationController
    before_action :get_job, only: [:destroy, :unlock, :custom, :show]
    before_action :filter_jobs, only: [:index, :destroy_all, :unlock_all, :bulk_custom_action]
    def index
      @queue_classic_jobs = @queue_classic_jobs.paginate(page: params[:page])
    end

    def destroy
      @queue_classic_job.destroy
      redirect_back fallback_location: {action: :index}
    end

    def destroy_all
      @queue_classic_jobs.delete_all
      redirect_to queue_classic_jobs_url
    end

    def unlock_all
      @queue_classic_jobs.where('locked_at < ?', 5.minutes.ago).update_all(locked_at: nil)
      redirect_to queue_classic_jobs_url
    end

    def bulk_custom_action
      custom_action = QueueClassicAdmin.custom_bulk_actions[params[:custom_action]]
      custom_action.action.call(@queue_classic_jobs)

      redirect_to queue_classic_jobs_url
    end

    def unlock
      @queue_classic_job.locked_at = nil
      @queue_classic_job.save
      redirect_back fallback_location: {action: :index}
    end

    def show
      query = "SELECT * FROM pg_catalog.pg_locks lock JOIN pg_catalog.pg_stat_activity stat ON lock.pid = stat.pid WHERE lock.pid = #{@queue_classic_job.locked_by.to_i}"
      @locks = QueueClassicJob.connection.execute(query)
    end

    def custom
      custom_action = QueueClassicAdmin.custom_actions[params[:custom_action]]
      custom_action.action.call(@queue_classic_job)
      redirect_back fallback_location: {action: :index}
    end

    private
    def index_path(*params)
      queue_classic_jobs_path(*params)
    end

    def get_job
      @queue_classic_job = QueueClassicJob.find(params[:id])
    end

    def scheduled?
      false
    end

    helper_method :index_path
    helper_method :scheduled?
  end
end
