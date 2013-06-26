require_dependency "queue_classic_admin/application_controller"

module QueueClassicAdmin
  class QueueClassicJobsController < ApplicationController
    # GET /queue_classic_jobs
    # GET /queue_classic_jobs.json
    def index
      @queue_classic_jobs = QueueClassicJob.all
  
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @queue_classic_jobs }
      end
    end
  
    # DELETE /queue_classic_jobs/1
    # DELETE /queue_classic_jobs/1.json
    def destroy
      @queue_classic_job = QueueClassicJob.find(params[:id])
      @queue_classic_job.destroy
  
      respond_to do |format|
        format.html { redirect_to queue_classic_jobs_url }
        format.json { head :no_content }
      end
    end
  end
end
